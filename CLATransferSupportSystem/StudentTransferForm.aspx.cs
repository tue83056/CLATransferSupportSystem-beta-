using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace CLATransferSupportSystem
{
    public partial class StudentTransferForm : System.Web.UI.Page
    {
        StoredProcedure sp = new StoredProcedure();
        private string recaptchaKey = ConfigurationManager.AppSettings["recaptcha-secret-key"];

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                populateTermDropDown();
                populateMajorsDropdown();
            }
           
        }

        private void populateMajorsDropdown()
        {
            ddlAnticipatedTUMajor.DataSource = sp.getActiveMajors();
            ddlAnticipatedTUMajor.DataTextField = "majorDescription";
            ddlAnticipatedTUMajor.DataValueField = "majorID";
            ddlAnticipatedTUMajor.DataBind();

            ListItem selectOne = new ListItem();
            selectOne.Value = "NA";
            selectOne.Text = "Select One";
            ddlAnticipatedTUMajor.Items.Insert(0, selectOne);
        }

        //Populates Term selection drop down with current year and next 5 years
        private void populateTermDropDown()
        {
            ddlTermYear.Items.Clear();
            System.DateTime moment = System.DateTime.Now;

            string currentyear = moment.Year.ToString();
            int year = Int32.Parse(currentyear);

            for (int i = year; i <= year + 5; i++)
            {
                ddlTermYear.Items.Add(i.ToString());
            }

            ListItem selectOne = new ListItem();
            selectOne.Value = "NA";
            selectOne.Text = "Select One";
            ddlTermYear.Items.Insert(0, selectOne);
        }

        protected void btnFormSubmit_Click(object sender, EventArgs e)
        {

            if (isRecaptchaValid()) //validate recaptcha
            {


                string termSelected = ddlTermName.Text + " " + ddlTermYear.Text;
                string TUmajor = ddlAnticipatedTUMajor.SelectedValue;

                //add student profile to database
                if (sp.addStudent(txtLastName.Text, txtFirstName.Text, txtEmail.Text, txtNumber.Text,
                    txtCurrentInstitution.Text, txtCurrentMajor.Text, txtAnticipatedTransferCredits.Text, ddlAssociates.Text,
                    ddlPAResident.Text, termSelected, ddlAnticipatedTUMajor.SelectedValue, txtStudentQuestion.Text))
                {
                    //send email
                    GridView gvEmail = new GridView();
                    StoredProcedure sp1 = new StoredProcedure();
                    gvEmail.DataSource = sp1.getEmail();
                    gvEmail.DataBind();
                    gvEmail.Visible = false;
                    string recipient = txtEmail.Text;
                    string Sender = "no-reply@temple.edu";
                    string title = gvEmail.Rows[0].Cells[1].Text;
                    string body = gvEmail.Rows[0].Cells[2].Text;
                    body = Server.HtmlDecode(body);
                    body = HttpUtility.HtmlDecode(body);
                    body = "<html> <body> <div> " + Server.HtmlDecode(body) + " </div> </body> </html>";
                    body = body.ToString();

                    if (gvEmail.Rows[0].Cells[5].Text.ToString() == "0")
                    {

                        sp.sendEmail(recipient, Sender, title, body);
                    }

                    txtAnticipatedTransferCredits.Text = "";
                    txtConfirmEmail.Text = "";
                    txtCurrentInstitution.Text = "";
                    txtCurrentMajor.Text = "";
                    txtEmail.Text = "";
                    txtFirstName.Text = "";
                    txtLastName.Text = "";
                    txtNumber.Text = "";
                    txtStudentQuestion.Text = "";

                    lblSubmitError.Visible = true;
                    lblSubmitError.Text = "valid - profile added";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "showThankYou();", true);
                    //Response.Redirect("Login.aspx");
                }

                else
                {
                    lblSubmitError.Visible = true;
                    lblSubmitError.Text = "database error";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "showErrorPopup();", true);
                }
            }
            else
            {
                lblSubmitError.Visible = true;
                lblSubmitError.Text = "invalid recaptcha";
            }
        }

        private bool isRecaptchaValid()
        {
            string Response = Request["g-recaptcha-response"];//Getting Response String Append to Post Method
            bool Valid = false;
            //Request to Google Server
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
            ("https://www.google.com/recaptcha/api/siteverify?secret=" + recaptchaKey + "&response=" + Response);
            try
            {
                //Google recaptcha Response
                using (WebResponse wResponse = req.GetResponse())
                {

                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                        JavaScriptSerializer js = new JavaScriptSerializer();
                        MyObject data = js.Deserialize<MyObject>(jsonResponse);// Deserialize Json

                        Valid = Convert.ToBoolean(data.success);
                    }
                }

                return Valid;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }

        public class MyObject
        {
            public string success { get; set; }
        }
    }
}

