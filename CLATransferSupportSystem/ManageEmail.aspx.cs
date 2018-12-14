using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CLATransferSupportSystem
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        StoredProcedure sp = new StoredProcedure();
        DateTime localDate = DateTime.Now;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccessLevel"] as string == "Administrator")
            {
                if (!IsPostBack)
                {

                    GridView gvEmail = new GridView();
                    gvEmail.DataSource = sp.getEmail();
                    gvEmail.DataBind();
                    txtSubject.Text = gvEmail.Rows[0].Cells[1].Text;
                    txtSummernote.Text = gvEmail.Rows[0].Cells[2].Text;
                    txtSummernote.Text = Server.HtmlDecode(txtSummernote.Text);


                    if (gvEmail.Rows[0].Cells[5].Text.ToString() == "1")
                    {
                        chkDisableEmail.Checked = true;
                    }

                    else
                    {
                        chkDisableEmail.Checked = false;
                    }

                }

                txtSummernote.Text = Server.HtmlDecode(txtSummernote.Text);
            }
            else if (Session["AccessLevel"] as string == "Reviewer")
            {
                Response.Redirect("AdvisorDashboard.aspx");
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }



        protected void btnSaveEmail_Click(object sender, EventArgs e)
        {


        }

        protected void btnTestEmail_Click(object sender, EventArgs e)
        {
            GridView gvEmail = new GridView();
            gvEmail.DataSource = sp.getEmail();
            gvEmail.DataBind();
            gvEmail.Visible = false;
            string recipient = txtTestemail.Text.ToString();
            string Sender = "no-reply@temple.edu";
            string title = gvEmail.Rows[0].Cells[1].Text;
            string body = gvEmail.Rows[0].Cells[2].Text;
            body = Server.HtmlDecode(body);
            body = HttpUtility.HtmlDecode(body);
            //this does not work
            body = "<html> <body> <div> " + Server.HtmlDecode(body) + " </div> </body> </html>";
            //body = body.Replace("\" ","\\\"");
            body = body.ToString();

            //this works due to the \ before each "
            //body = "<html> <body> <div> <span style=\"background - color: rgb(255, 255, 0); \"></span><p><span style=\"font - weight: bold; \"><span style=\"color: rgb(255, 0, 0); \">This is a test email for transfer<br></span></span></p></div> </body> </html>";
            sp.sendEmail(recipient, Sender, title, body);
            txtTestemail.Text = "";

        }

        protected void chkDisableEmail_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int disabled = 0;
            if (chkDisableEmail.Checked == true)
            {
                disabled = 1;
            }
            else
            {
                disabled = 0;
            }
            GridView gvEmail = new GridView();
            gvEmail.DataSource = sp.getEmail();
            gvEmail.DataBind();

            int id = Convert.ToInt32(gvEmail.Rows[0].Cells[0].Text);

            string myHtmlNew = Server.HtmlEncode(txtSummernote.Text);
            sp.updateEmail(txtSubject.Text, myHtmlNew, DateTime.Now.ToString("g"), disabled, id);

        }
    }
}