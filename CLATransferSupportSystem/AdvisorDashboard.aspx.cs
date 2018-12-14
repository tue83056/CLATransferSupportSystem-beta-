using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Globalization;

namespace CLATransferSupportSystem
{

    public partial class NEWAdvisorDashboard : System.Web.UI.Page
    {

        StoredProcedure sp = new StoredProcedure();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                populateMajorsDropdown();
                populateTermDropDown();


                populateStudentTable();
                populateInactiveStudents();
                populateMatriculatedStudents();

                

                if (Session["AccessLevel"] as string == "Reviewer")
                {
                    lbAddStudentProfile.Visible = false;



                }
                else
                {
                }

            }

        }

        private void populateStudentTable()
        {
            StoredProcedure sp2 = new StoredProcedure();
            rptStudents.DataSource = sp2.getStudentTableInfo();
            rptStudents.DataBind();
        }

        private void populateInactiveStudents()
        {
            StoredProcedure sp3 = new StoredProcedure();
            rptInactive.DataSource = sp3.getInactiveStudents();
            rptInactive.DataBind();
        }

        private void populateMatriculatedStudents()
        {
            rptMatriculated.DataSource = sp.getMatriculatedStudents();
            rptMatriculated.DataBind();
        }

        private void populateMajorsDropdown()
        {
            ddlAnticipatedTUMajor.DataSource = sp.getActiveMajors();
            ddlAnticipatedTUMajor.DataTextField = "majorDescription";
            ddlAnticipatedTUMajor.DataValueField = "majorID";
            ddlAnticipatedTUMajor.DataBind();
            ddlAnticipatedTUMajor.SelectedValue = ddlAnticipatedTUMajor.Items.FindByText("Unknown").Value; 
            

        }

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

        protected void lbAddStudentProfile_Click(object sender, EventArgs e)
        {
           
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string studentID = e.CommandArgument.ToString();
            
            
            if (e.CommandName == "ViewStudent")
            {
                Response.Redirect("StudentProfile.aspx?studentID=" + studentID);

            } else if (e.CommandName == "DisableStudent")
            {
                sp.disableStudent(Int32.Parse(studentID));
                populateInactiveStudents();
                populateStudentTable();

            } else if (e.CommandName == "RestoreStudent")
            {
                sp.restoreStudent(Int32.Parse(studentID));
                populateInactiveStudents();
                populateStudentTable();

            } else if (e.CommandName == "DeleteStudent")
            {
                sp.deleteStudent(Int32.Parse(studentID));
                populateInactiveStudents();
                populateStudentTable();
            }
        }

       

        public override void VerifyRenderingInServerForm(Control control)
        {

        }

        protected void lbAddNewProfile_Click(object sender, EventArgs e)
        {
            string anticipatedMatricTerm = ddlTermName.SelectedItem.Text + " " + ddlTermYear.SelectedItem.Text;

            string lastUpdatedBy = Session["firstname"] +" "+ Session["lastname"];

            if (sp.manuallyAddStudent(txtLastName.Text, txtFirstName.Text, txtEmail.Text, txtPhone.Text, txtCurrentInstitution.Text, txtCurrentMajor.Text, txtAnticipatedTransferCredits.Text, ddlAssociatesStatus.SelectedItem.Text, ddlPAResident.SelectedItem.Text, anticipatedMatricTerm, ddlAnticipatedTUMajor.SelectedValue, lastUpdatedBy))
            {
                populateStudentTable();
                txtLastName.Text = "";
                txtFirstName.Text = "";
                txtPhone.Text = "";
                txtEmail.Text = "";
                txtConfirmEmail.Text = "";
                txtCurrentInstitution.Text = "";
                txtCurrentMajor.Text = "";
                txtAnticipatedTransferCredits.Text = "";

            } else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showErrorPopup();", true);
            }
           

        }

        protected void rptStudents_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lbDisable = (LinkButton)e.Item.FindControl("lbDisable");
                

                if (Session["AccessLevel"] as string == "Reviewer")
                {
                    lbDisable.Visible = false;
                    

                }
            }
        }

        protected void rptInactive_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lbRestore = (LinkButton)e.Item.FindControl("lbRestore");
                LinkButton lbDelete = (LinkButton)e.Item.FindControl("lbDelete");

                if (Session["AccessLevel"] as string == "Reviewer")
                {
                    lbRestore.Visible = false;
                    lbDelete.Visible = false;

                }
            }
        }
    }
}