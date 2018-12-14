using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace CLATransferSupportSystem
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        StoredProcedure sp = new StoredProcedure();
        

        //page init
        protected override void OnInitComplete(EventArgs e)
        {
            base.OnInitComplete(e);
            Repeater1.ItemDataBound += new RepeaterItemEventHandler(RepeaterItemDataBound);

            if (!IsPostBack)
            {
                populateAdmin();
            }
           

        }

        //page load
        protected void Page_Load(object sender, EventArgs e)
        {
            //populateAdmin();
            if (Session["AccessLevel"] as string == "Administrator")
            {

                
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


        //populate admin table
        private void populateAdmin()
        {
            StoredProcedure sp2 = new StoredProcedure();
            DataSet ds = sp2.getAdminInfo();
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }



        //binding items in repeater for table
        protected void RepeaterItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
        e.Item.ItemType == ListItemType.AlternatingItem)
            {

                //DataSet ds = sp.getAdminInfo();
                //string value = (ds.Tables[0].Rows[e.Item.ItemIndex]["adminStatus"].ToString());

                DropDownList ddlAdmin = (DropDownList)e.Item.FindControl("ddlAdmin");
                ddlAdmin.SelectedIndexChanged += new EventHandler(ddlAdmin_SelectedIndexChanged);

                Label lblStatus = (Label)e.Item.FindControl("lblHiddenStatus");

                ddlAdmin.SelectedValue = lblStatus.Text;


                DropDownList ddlAccessLevel = (DropDownList)e.Item.FindControl("ddlAccessLevelRpt");
                ddlAccessLevel.SelectedIndexChanged += new EventHandler(ddlAccessLevelRpt_SelectedIndexChanged);

                Label lblAccessLevel = (Label)e.Item.FindControl("lblHiddenAccessLevel");
                ddlAccessLevel.SelectedValue = lblAccessLevel.Text;




            }
           
        }

        //when status dropdown list is changed, updates database, re-populates table
        protected void ddlAdmin_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList d = (DropDownList)sender;
            string status = d.SelectedValue;

            Label lblTUID = (Label)d.Parent.FindControl("lblHiddenTUID");

            int TUID = Int32.Parse(lblTUID.Text);

            sp.updateAdminStatus(TUID, status);
            populateAdmin();

        }

        protected void ddlAccessLevelRpt_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList d = (DropDownList)sender;
            string accessLevel = d.SelectedValue;

            Label lblTUID = (Label)d.Parent.FindControl("lblHiddenTUID");

            int TUID = Int32.Parse(lblTUID.Text);

            sp.updateAdminAccess(TUID, accessLevel);
            populateAdmin();
        }

        protected void btnAddAdmin_Click(object sender, EventArgs e)
        {
            
            StoredProcedure sp3 = new StoredProcedure();
            string accessnet = txtUsername.Text;
            string lastname = txtLastName.Text;
            string firstname = txtFirstName.Text;
            string id = txtTUID.Text;
            string level = ddlAccessLevel.SelectedValue.ToString();


            sp3.addAdmin(Convert.ToInt32(id), accessnet, lastname, firstname, level, System.DateTime.Today.ToShortDateString(), "Active", "999999999");
            populateAdmin();
            txtUsername.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtTUID.Text = "";


        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int TUID = Int32.Parse(e.CommandArgument.ToString());

          

            if (e.CommandName == "RemoveAdmin")
            {

                sp.deleteAdmin(TUID);
                populateAdmin();
           
            } 
        }

        protected void btnFindUser_Click(object sender, EventArgs e)
        {
            string accessnet = findAccessNetID.Text;
            LDAPuser user = new LDAPuser();
            user = Login.getLDAPEntryByAccessnet(accessnet);

            if (user != null)
            {              
                txtLastName.Text = user.sn;
                txtFirstName.Text = user.givenName;
                txtTUID.Text = user.templeEduID;
                txtUsername.Text = user.uID;
                lblFoundID.Text = "true";

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showAddAdminPopup();", true);
                findAccessNetID.Text = "";

               
            } else
            {
                lblFoundID.Text = "false";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showNotFoundPopup();", true);
                findAccessNetID.Text = "";
                
            }
        }
    }
}