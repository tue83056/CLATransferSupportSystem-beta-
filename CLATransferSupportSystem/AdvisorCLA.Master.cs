using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CLATransferSupportSystem
{
    public partial class AdvisorCLA : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();

            if (!string.IsNullOrWhiteSpace(Session["UserName"] as string))
            {

                lblLogout.Text = " " + Session["firstname"] + " " + Session["lastname"];

                if (Session["AccessLevel"] as string == "Administrator")
                {


                    navdropdown.Visible = true;

                }
                else
                {

                    navdropdown.Visible = false;
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void LoginStatus_LoggedOut(Object sender, System.EventArgs e)
        {
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}