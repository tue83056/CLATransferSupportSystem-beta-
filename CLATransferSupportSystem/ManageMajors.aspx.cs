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
    public partial class WebForm1 : System.Web.UI.Page
    {
        StoredProcedure sp = new StoredProcedure();

        protected override void OnInitComplete(EventArgs e)
        {
            base.OnInitComplete(e);
            rptMajors.ItemDataBound += new RepeaterItemEventHandler(RepeaterItemDataBound);

            if (!IsPostBack)
            {
                populateMajors();
            }


        }

        protected void Page_Load(object sender, EventArgs e)
        {
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

        private void populateMajors()
        {
            StoredProcedure sp2 = new StoredProcedure();
            DataSet ds = sp2.getMajorInfo();
            rptMajors.DataSource = ds;
            rptMajors.DataBind();
        }

        //Selects the correct item from the database that is selected in the dropdown
        protected void RepeaterItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
         e.Item.ItemType == ListItemType.AlternatingItem)
            {

                //DataSet ds = sp.getMajorInfo();
                //string value = (ds.Tables[0].Rows[e.Item.ItemIndex]["majorStatus"].ToString());
                //((DropDownList)e.Item.FindControl("ddlMajor")).SelectedValue = value;

                DropDownList ddlMajor = (DropDownList)e.Item.FindControl("ddlMajor");
                ddlMajor.SelectedIndexChanged += new EventHandler(ddlMajor_SelectedIndexChanged);

                Label lblStatus = (Label)e.Item.FindControl("lblHiddenStatus");

                ddlMajor.SelectedValue = lblStatus.Text;


            }
        }

        protected void ddlMajor_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList d = (DropDownList)sender;
            string status = d.SelectedValue;

            Label lblMajorID = (Label)d.Parent.FindControl("lblHiddenID");

            int majorID = Int32.Parse(lblMajorID.Text);

            sp.updateMajorStatus(majorID, status);
            populateMajors();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            StoredProcedure sp3 = new StoredProcedure();
            string description = txtMajorDescription.Text;

            sp3.addMajor(description, "Active", "87564564");
            populateMajors();
            txtMajorDescription.Text = "";

        }

        protected void rptMajors_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int majorID = Int32.Parse(e.CommandArgument.ToString());

            Label lblDescription = (Label)e.Item.FindControl("lblMajorDescription");
            TextBox txtEditDescription = (TextBox)e.Item.FindControl("txtEditDescription");
            LinkButton lbCancel = (LinkButton)e.Item.FindControl("lbCancelEdit");
            LinkButton lbUpdate = (LinkButton)e.Item.FindControl("lbUpdate");
            LinkButton lbEdit = (LinkButton)e.Item.FindControl("lbEditMajor");

            if (e.CommandName == "EditMajor")
            {
                
                lbCancel.Visible = true;
                lbUpdate.Visible = true;
                lbEdit.Visible = false;

                lblDescription.Visible = false;
                txtEditDescription.Visible = true;
                txtEditDescription.Text = lblDescription.Text;
                


            } else if (e.CommandName == "CancelEdit")
            {
             
                txtEditDescription.Visible = false;
                lblDescription.Visible = true;

                lbUpdate.Visible = false;
                lbCancel.Visible = false;
                lbEdit.Visible = true;

            } else if (e.CommandName == "Update")
            {
                lbEdit.Visible = true;
                lbUpdate.Visible = false;
                lbCancel.Visible = false;

                sp.updateMajorDescription(majorID, txtEditDescription.Text);
                populateMajors();

            }
            
             

        }
    }
}