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
using System.Web.UI.HtmlControls;

namespace CLATransferSupportSystem
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        private StoredProcedure sp = new StoredProcedure();
        private int studentID;

        //columns in sql query table
        private const int LAST_NAME_COL = 1;
        private const int FIRST_NAME_COL = 2;
        private const int EMAIL_COL = 3;
        private const int PHONE_COL = 4;
        private const int CURRENT_INST_COL = 5;
        private const int CURRENT_MAJOR_COL = 6;
        private const int ANT_CREDITS_COL = 7;
        private const int ASSOCIATE_COL = 8;
        private const int PA_RES_COL = 13;
        private const int ANT_MATR_TERM = 14;
        private const int ANT_TU_MAJOR = 15;
        private const int HAS_MATRIC_COL = 11;
        private const int MATRIC_TERM_COL = 12;
        private const int INITIAL_CONTACT_DATE_COL = 9;
        private const int LAST_CONTACT_DATE_COL = 10;
        private const int LAST_UPDATED_BY_ADMIN_COL = 16;

        //columns in document table
        private const int DOC_NAME_COL = 1;
        private const int FILE_DATA_COL = 4;



        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                populateMajorsDropdown();
                populateTermDropDown();
                lblNewEntryDate.Text = DateTime.Today.ToShortDateString();
                lblEntryAddedBy.Text = Session["firstname"] + " " + Session["lastname"];


                if (isStudentIDValid())
                {
                    if (Int32.TryParse(Request.QueryString["studentID"], out studentID))
                    {
                        lblStudentID.Text = studentID.ToString();
                        populateStudentInformation(Int32.Parse(lblStudentID.Text));
                        populateEntries(Int32.Parse(lblStudentID.Text));
                        populateDocuments();


                        studentID = Int32.Parse(lblStudentID.Text);
                        StoredProcedure sp5 = new StoredProcedure();
                        if (sp5.GetIsMatriculated(studentID) == "Yes" || Session["AccessLevel"] as string == "Reviewer")
                        {
                            btnEditStudentInfo.Visible = false;
                            btnSaveStudentInfo.Visible = false;
                            btnExportStudent.Visible = false;
                            btnUploadDocument.Enabled = false;
                            ddlFileCategory.Enabled = false;
                            FileUpload1.Enabled = false;
                            btnAddEntry.Visible = false;
                            btnExport.Visible = false;

                        }
                    }

                }

            }

        }

        private bool isStudentIDValid()
        {
            bool valid = false;

            if (!String.IsNullOrWhiteSpace(Request.QueryString["studentID"]))
            {
                valid = true;

            }
            return valid;
        }

        //populates conversation entries
        private void populateEntries(int studentID)
        {
            StoredProcedure sp2 = new StoredProcedure();
            DataSet ds = sp2.getEntries(studentID);
            int totalEntries = ds.Tables[0].Rows.Count;
            lblTotalEntries.Text = totalEntries.ToString();
            rptEntries.DataSource = ds;
            rptEntries.DataBind();
            lblNewEntryNumber.Text = (rptEntries.Items.Count + 1).ToString();



        }

        //populates major selection drop down with values from db
        private void populateMajorsDropdown()
        {
            ddlAnticipatedTUMajor.DataSource = sp.getMajorInfo();
            ddlAnticipatedTUMajor.DataTextField = "majorDescription";
            ddlAnticipatedTUMajor.DataValueField = "majorID";
            ddlAnticipatedTUMajor.DataBind();
        }

        private void populateDocuments()
        {
            StoredProcedure sp2 = new StoredProcedure();
            rptUploadedDocuments.DataSource = sp2.getDocuments(Int32.Parse(lblStudentID.Text));
            rptUploadedDocuments.DataBind();

        }

        //populates relevant student information fields
        private void populateStudentInformation(int studentID)
        {
            StoredProcedure sp3 = new StoredProcedure();
            DataSet ds = sp3.getStudentInformation(studentID);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtLastName.Text = ds.Tables[0].Rows[0][LAST_NAME_COL].ToString();
                txtFirstName.Text = ds.Tables[0].Rows[0][FIRST_NAME_COL].ToString();

                studentNameHeading.InnerText = "    Student Profile: " + txtFirstName.Text + " " + txtLastName.Text;

                txtEmail.Text = ds.Tables[0].Rows[0][EMAIL_COL].ToString();
                txtPhone.Text = ds.Tables[0].Rows[0][PHONE_COL].ToString();
                txtCurrentInstitution.Text = ds.Tables[0].Rows[0][CURRENT_INST_COL].ToString();
                txtCurrentMajor.Text = ds.Tables[0].Rows[0][CURRENT_MAJOR_COL].ToString();
                txtAnticipatedTransferCredits.Text = ds.Tables[0].Rows[0][ANT_CREDITS_COL].ToString();

                string associateStatus = ds.Tables[0].Rows[0][ASSOCIATE_COL].ToString();
                ddlAssociatesStatus.Items.FindByText(associateStatus).Selected = true;

                string TUMajor = ds.Tables[0].Rows[0][ANT_TU_MAJOR].ToString();
                ddlAnticipatedTUMajor.Items.FindByValue(TUMajor).Selected = true;

                string anticipatedMatricTerm = ds.Tables[0].Rows[0][ANT_MATR_TERM].ToString();
                string[] strTerm = anticipatedMatricTerm.Split(' ');
                ddlTermName.Items.FindByText(strTerm[0]).Selected = true;
                ddlTermYear.Items.FindByText(strTerm[1]).Selected = true;

                string paResident = ds.Tables[0].Rows[0][PA_RES_COL].ToString();
                ddlPAResident.Items.FindByText(paResident).Selected = true;

                string hasMatric = ds.Tables[0].Rows[0][HAS_MATRIC_COL].ToString();
                lblHasMatriculated.Text = hasMatric;

                string matricTerm = ds.Tables[0].Rows[0][MATRIC_TERM_COL].ToString();
                lblMatriculationTerm.Text = matricTerm;             

               
                lblInitialContactDate.Text = ds.Tables[0].Rows[0][INITIAL_CONTACT_DATE_COL].ToString();
                lblLastUpdated.Text = ds.Tables[0].Rows[0][LAST_CONTACT_DATE_COL].ToString();

                lblLastUpdatedBy.Text = ds.Tables[0].Rows[0][LAST_UPDATED_BY_ADMIN_COL].ToString();

            }


        }

        //updates student information when Save is clicked
        private void updateStudentInformation()
        {
            studentNameHeading.InnerText = "Student Profile: " + txtFirstName.Text + " " + txtLastName.Text;
            int studentID = Int32.Parse(lblStudentID.Text);
            int majorID = Int32.Parse(ddlAnticipatedTUMajor.SelectedValue);

            string studentLastName = txtLastName.Text;
            string studentFirstName = txtFirstName.Text;
            string studentEmail = txtEmail.Text;
            string studentPhone = txtPhone.Text;
            string currentInstitution = txtCurrentInstitution.Text;
            string currentMajor = txtCurrentMajor.Text;
            string anticipatedTransferCredits = txtAnticipatedTransferCredits.Text;
            string associateStatus = ddlAssociatesStatus.SelectedItem.Text;

            string anticipatedMatriculationTerm = ddlTermName.SelectedItem.Text + " " + ddlTermYear.SelectedItem.Text;
            string isPAResident = ddlPAResident.SelectedItem.Text;
            string hasMatriculated = lblHasMatriculated.Text;

            string lastUpdatedBy = Session["firstname"] + " " + Session["lastname"];

            sp.updateStudentInformation(studentID, studentLastName, studentFirstName, studentEmail, studentPhone, currentInstitution, currentMajor, anticipatedTransferCredits, associateStatus, hasMatriculated, isPAResident, anticipatedMatriculationTerm, majorID, lastUpdatedBy);
            populateStudentInformation(Int32.Parse(lblStudentID.Text));
        }

        //Populates Term selection drop down with current year and next 5 years
        private void populateTermDropDown()
        {
            ddlTermYear.Items.Clear();
            ddlTermYearExport.Items.Clear();
            System.DateTime moment = System.DateTime.Now;

            string currentyear = moment.Year.ToString();
            int year = Int32.Parse(currentyear);

            for (int i = year; i <= year + 5; i++)
            {
                ddlTermYear.Items.Add(i.ToString());
                ddlTermYearExport.Items.Add(i.ToString());
                //ddlMatricTermYear.Items.Add(i.ToString());
            }

            ListItem selectOne = new ListItem();
            selectOne.Value = "NA";
            selectOne.Text = "Select One";
            ddlTermYearExport.Items.Insert(0, selectOne);

            //ListItem item = new ListItem();
            //item.Text = "NA";
            //ddlMatricTermYear.Items.Insert(0, item);

        }

        protected void btnEditStudentInfo_Click(object sender, EventArgs e)
        {
            txtLastName.ReadOnly = false;
            txtFirstName.ReadOnly = false;
            txtEmail.ReadOnly = false;
            txtPhone.ReadOnly = false;
            txtCurrentInstitution.ReadOnly = false;
            txtAnticipatedTransferCredits.ReadOnly = false;
            txtCurrentMajor.ReadOnly = false;
            ddlAnticipatedTUMajor.Enabled = true;
            ddlAssociatesStatus.Enabled = true;
            //ddlHasMatriculated.Enabled = true;
            ddlPAResident.Enabled = true;
            ddlTermName.Enabled = true;
            ddlTermYear.Enabled = true;

        }

        protected void btnSaveStudentInfo_Click(object sender, EventArgs e)
        {
            updateStudentInformation();

            txtLastName.ReadOnly = true;
            txtFirstName.ReadOnly = true;
            txtEmail.ReadOnly = true;
            txtPhone.ReadOnly = true;
            txtCurrentInstitution.ReadOnly = true;
            txtAnticipatedTransferCredits.ReadOnly = true;
            txtCurrentMajor.ReadOnly = true;
            ddlAnticipatedTUMajor.Enabled = false;
            ddlAssociatesStatus.Enabled = false;
            //ddlHasMatriculated.Enabled = false;
            ddlPAResident.Enabled = false;
            ddlTermName.Enabled = false;
            ddlTermYear.Enabled = false;


        }

        protected void btnAddEntry_Click(object sender, EventArgs e)
        {
            //insert validation for adding entry

            int studentID = Int32.Parse(lblStudentID.Text);
            string contactType = ddlContactType.SelectedItem.Text;
            string dateAdded = DateTime.Today.ToString("MM/dd/yyyy");
            string entryText = txtNewConversationEntry.Text;
            string addedBy = Session["firstname"] + " " + Session["lastname"];

            sp.addEntry(studentID, contactType, dateAdded, entryText, addedBy);

            populateEntries(Int32.Parse(lblStudentID.Text));
            txtNewConversationEntry.Text = "";
            //lblEntrySuccess.Visible = true;
            //lblEntrySuccess.Text = "Successfully added entry.";

        }

        protected void rptEntries_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int entryID = Int32.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "EditEntry")
            {
                TextBox tBox = (TextBox)e.Item.FindControl("txtEntryText");
                HtmlGenericControl div = (HtmlGenericControl)e.Item.FindControl("txtHidden");
                div.Visible = false;
                tBox.Visible = true;
                tBox.Enabled = true;
                LinkButton lbCancel = (LinkButton)e.Item.FindControl("lbCancelEdit");
                LinkButton lbUpdate = (LinkButton)e.Item.FindControl("lbUpdateEntry");
                LinkButton lbEdit = (LinkButton)e.Item.FindControl("lbEditEntry");
                lbEdit.Visible = false;
                lbCancel.Visible = true;
                lbUpdate.Visible = true;


            }
            else if (e.CommandName == "CancelEdit")
            {
                TextBox tBox = (TextBox)e.Item.FindControl("txtEntryText");
                HtmlGenericControl div = (HtmlGenericControl)e.Item.FindControl("txtHidden");
                div.Visible = true;
                tBox.Visible = false;
                tBox.Enabled = false;
                LinkButton lbCancel = (LinkButton)e.Item.FindControl("lbCancelEdit");
                LinkButton lbUpdate = (LinkButton)e.Item.FindControl("lbUpdateEntry");
                LinkButton lbEdit = (LinkButton)e.Item.FindControl("lbEditEntry");
                lbEdit.Visible = true;
                lbCancel.Visible = false;
                lbUpdate.Visible = false;
                populateEntries(Int32.Parse(lblStudentID.Text));

            }
            else if (e.CommandName == "UpdateEntry")
            {

                TextBox tBox = (TextBox)e.Item.FindControl("txtEntryText");
                string entryText = tBox.Text;

                sp.updateEntry(entryID, entryText);
                populateEntries(Int32.Parse(lblStudentID.Text));


            }
            else if (e.CommandName == "DeleteEntry")
            {
                sp.deleteEntry(entryID);
                populateEntries(Int32.Parse(lblStudentID.Text));
            }

        }

        protected void rptEntries_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            int totalEntries = 0;
            Int32.TryParse(lblTotalEntries.Text, out totalEntries);

            int currentIndex = e.Item.ItemIndex;

            Label lblIndex = (Label)e.Item.FindControl("lblIndex");

            lblIndex.Text = (totalEntries - currentIndex).ToString();

            TextBox tbox = (TextBox)e.Item.FindControl("txtEntryText");
                    

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lbEditEntry = (LinkButton)e.Item.FindControl("lbEditEntry");
                LinkButton lbDeleteEntry = (LinkButton)e.Item.FindControl("lbDeleteEntry");

                if (Session["AccessLevel"] as string == "Reviewer")
                {
                    lbEditEntry.Visible = false;
                    lbDeleteEntry.Visible = false;

                }
            }

        }

        protected void rptUploadedDocuments_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lbDeleteDocument = (LinkButton)e.Item.FindControl("lbDeleteDocument");

                if (Session["AccessLevel"] as string == "Reviewer")
                {
                    lbDeleteDocument.Visible = false;

                }
            }

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
                string documentCategory = ddlFileCategory.SelectedItem.Text;
                int studentID = Int32.Parse(lblStudentID.Text);

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
                    case ".xls":
                        contenttype = "application/vnd.ms-excel";
                        break;
                    case ".xlsx":
                        contenttype = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        break;
                    default:
                        contenttype = "invalid";
                        ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", "alert('Invalid file type. Try another file.');", true);
                        return;
                        

                }

                Stream fs = FileUpload1.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                Byte[] bytes = br.ReadBytes((Int32)fs.Length);

                string addedBy = Session["firstname"] + " " + Session["lastname"];

                //insert the file into database 
                sp.uploadDocument(filename, documentCategory, bytes, studentID, addedBy);

                //Response.Redirect(Request.RawUrl);
                populateDocuments();
            }
        }

        protected void rptUploadedDocuments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int documentID = Int32.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "DownloadDocument")
            {
                DataSet ds = sp.getDocument(documentID);
                DataTable dt = ds.Tables[0];

                string documentName = dt.Rows[0][DOC_NAME_COL].ToString();
                byte[] fileData = (byte[])dt.Rows[0][FILE_DATA_COL];

                Response.ClearContent();
                Response.ContentType = "application/octetstream";
                Response.AddHeader("content-Disposition", string.Format("attachment; filename={0}", documentName));
                Response.AddHeader("content-Length", fileData.Length.ToString());
                Response.BinaryWrite(fileData);
                Response.Flush();
                Response.Close();

            }
            else if (e.CommandName == "DeleteDocument")
            {
                sp.deleteDocument(documentID);
                populateDocuments();
            }
        }


        protected void btnFindStudent_Click(object sender, EventArgs e)
        {
            string tuID = findTUID.Text;
            LDAPuser user = new LDAPuser();
            user = Login.getLDAPEntryByTUID(tuID);

            if (user != null)
            {
                txtExportLastName.Text = user.sn;
                txtExportFirstName.Text = user.givenName;
                txtExportTUID.Text = user.templeEduID;
                txtExportUsername.Text = user.uID;
                lblFoundID.Text = "true";

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showExportPopup();", true);
                findTUID.Text = "";


            }
            else
            {
                lblFoundID.Text = "false";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showNotFoundPopup();", true);
                findTUID.Text = "";

            }
        }

        protected void btnExportStudent_Click(object sender, EventArgs e)
        {
            int studentID = Int32.Parse(lblStudentID.Text);
            string StudID = txtExportTUID.Text;
            string matriculationterm = ddlTermNameExport.SelectedItem.Text + " " + ddlTermYearExport.SelectedItem.Text;
            //txtFirstName.Text = Int32.Parse(lblStudentID.Text).ToString();
            //txtLastName.Text = txtExportTUID.Text;
            sp.addEntryExport(StudID, studentID);
            sp.matriculateStudent(studentID);
            sp.updateMatriculationTerm(studentID, matriculationterm);
            Response.Redirect("AdvisorDashboard.aspx");
        }
    }
}