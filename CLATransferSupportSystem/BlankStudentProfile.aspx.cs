using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace CLATransferSupportSystem
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        DBConnect myDB = new DBConnect();


        protected void Page_Load(object sender, EventArgs e)
        {
            
                    if (!Page.IsPostBack)
                    {
                        txtLastName.ReadOnly = false;
                        txtFirstName.ReadOnly = false;
                        txtDOB.ReadOnly = false;
                        txtEmail.ReadOnly = false;
                        txtPhone.ReadOnly = false;
                        txtCurrentInstitution.ReadOnly = false;
                        txtAnticipatedTransferCredits.ReadOnly = false;
                        txtCurrentMajor.ReadOnly = false;
                        ddlAnticipatedTUMajor.Enabled = true;
                        ddlAssociatesStatus.Enabled = true;
                        ddlHasMatriculated.Enabled = true;

                        getFiles();
                    }
                


        }

        protected void btnEditStudentInfo_Click(object sender, EventArgs e)
        {
            txtLastName.ReadOnly = false;
            txtFirstName.ReadOnly = false;
            txtDOB.ReadOnly = false;
            txtEmail.ReadOnly = false;
            txtPhone.ReadOnly = false;
            txtCurrentInstitution.ReadOnly = false;
            txtAnticipatedTransferCredits.ReadOnly = false;
            txtCurrentMajor.ReadOnly = false;
            ddlAnticipatedTUMajor.Enabled = true;
            ddlAssociatesStatus.Enabled = true;
            ddlHasMatriculated.Enabled = true;
        }

        protected void btnSaveStudentInfo_Click(object sender, EventArgs e)
        {
            txtLastName.ReadOnly = true;
            txtFirstName.ReadOnly = true;
            txtDOB.ReadOnly = true;
            txtEmail.ReadOnly = true;
            txtPhone.ReadOnly = true;
            txtCurrentInstitution.ReadOnly = true;
            txtAnticipatedTransferCredits.ReadOnly = true;
            txtCurrentMajor.ReadOnly = true;
            ddlAnticipatedTUMajor.Enabled = false;
            ddlAssociatesStatus.Enabled = false;
            ddlHasMatriculated.Enabled = false;
        }

        protected void btnUploadDocument_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile == false)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", "alert('Please select a file to upload');", true);
            }

            else
            {

                string filePath = FileUpload1.PostedFile.FileName;
                string filename = Path.GetFileName(filePath);
                string ext = Path.GetExtension(filename);
                string contenttype = String.Empty;

                //Set the contenttype based on File Extension
                switch (ext)
                {
                    case ".doc":
                        contenttype = "application/vnd.ms-word";
                        break;
                    case ".docx":
                        contenttype = "application/vnd.ms-word";
                        break;
                    case ".pdf":
                        contenttype = "application/pdf";
                        break;
                }

                Stream fs = FileUpload1.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                Byte[] bytes = br.ReadBytes((Int32)fs.Length);

                //insert the file into database
                //store Procedure will look different depending on tables

                DBConnect objDB = new DBConnect();
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "uploadFile";
                objCommand.Parameters.AddWithValue("@documentName", filename);
                objCommand.Parameters.AddWithValue("@documentCategory", ddlFileCategory.SelectedValue);
                objCommand.Parameters.AddWithValue("@dateUploaded", DateTime.Now);
                objCommand.Parameters.AddWithValue("@fileData", bytes);
                objCommand.Parameters.AddWithValue("@studentID", 123456789);
                objCommand.Parameters.AddWithValue("@addedByAdmin", 987654321);
                objCommand.Parameters.AddWithValue("@documentType", contenttype);

                objDB.DoUpdateUsingCmdObj(objCommand);
                Response.Redirect(Request.RawUrl);
                getFiles();
            }

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            FileUpload1.Attributes.Clear();

        }

        protected void btnDownloadDocument_Click(object sender, EventArgs e)
        {


            Button clickedButton = (Button)sender;
            GridViewRow row = (GridViewRow)clickedButton.Parent.Parent;
            int rowIndex = row.RowIndex;
            DataSet ds = new DataSet();

            SqlCommand myCommand = new SqlCommand();
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "getFile";
            ds = myDB.GetDataSetUsingCmdObj(myCommand);
            DataTable dt = ds.Tables[0];

            string path = dt.Rows[rowIndex]["documentName"].ToString();
            byte[] bts = (byte[])dt.Rows[rowIndex]["fileData"];
            Response.ClearContent();
            Response.ContentType = "application/octetstream";
            Response.AddHeader("content-Disposition", string.Format("attachment; filename={0}", path));
            Response.AddHeader("content-Length", bts.Length.ToString());
            Response.BinaryWrite(bts);
            Response.Flush();
            Response.Close();

        }

        protected void getFiles()
        {
            SqlCommand myCommand = new SqlCommand();
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "getFile";
            gvShowFiles.DataSource = myDB.GetDataSetUsingCmdObj(myCommand);
            gvShowFiles.DataBind();
        }

        protected void gvShowFiles_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {

            int rowindex = e.RowIndex;
            int id = int.Parse(gvShowFiles.Rows[rowindex].Cells[0].Text);


            SqlCommand myCommand = new SqlCommand();
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "deleteFile";
            myCommand.Parameters.AddWithValue("@documentID", id);
            myDB.DoUpdateUsingCmdObj(myCommand);


            gvShowFiles.EditIndex = -1;
            Response.Redirect(Request.RawUrl);
            getFiles();

        }

        protected void gvShowFiles_PageIndexChanging(Object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)

        {

            // Set the GridView to display the correct page

            gvShowFiles.PageIndex = e.NewPageIndex;

            getFiles();


        }
    }
}