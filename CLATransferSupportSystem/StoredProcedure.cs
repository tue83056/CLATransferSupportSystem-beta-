using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace CLATransferSupportSystem
{
    //Add code to add parameters, and execute database stored procedures
    //used to populate lists, tables, update database
    public class StoredProcedure
    {

        //Connection object
        DBConnect objDB = new DBConnect();
        Email email = new Email();
        //public methods

        public Boolean addEmail(string eSubject, string eBody)
        {

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "addEmail";
            objCommand.Parameters.AddWithValue("@emailSubject", eSubject);
            objCommand.Parameters.AddWithValue("@emailBody", eBody);

                if (objDB.DoUpdateUsingCmdObj(objCommand) != -1)
                {
                    return true;
                }

            return false;
        }
      
        public Boolean addStudent(string sLast, string sFirst, string sEmail, string sPhone,
            string sCurI, string sCurM, string sAntT, string sAssS, 
            string sIsPA, string sAntMT, string AntTUM, string entryText)         
        {
            int majorID = 0;
            Int32.TryParse(AntTUM, out majorID);

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "addStudent";
            objCommand.Parameters.AddWithValue("@stuLastName", sLast);
            objCommand.Parameters.AddWithValue("@stuFirstName", sFirst);
            objCommand.Parameters.AddWithValue("@stuEmail", sEmail);
            objCommand.Parameters.AddWithValue("@stuPhone", sPhone);
            objCommand.Parameters.AddWithValue("@curInst", sCurI);
            objCommand.Parameters.AddWithValue("@curMaj", sCurM);
            objCommand.Parameters.AddWithValue("@antTranCred", sAntT);
            objCommand.Parameters.AddWithValue("@assoStat", sAssS);
            objCommand.Parameters.AddWithValue("@initContDa", DateTime.Today.ToShortDateString());
            objCommand.Parameters.AddWithValue("@lastCont", DateTime.Today.ToShortDateString());
            objCommand.Parameters.AddWithValue("@hasMatri", "No");
            objCommand.Parameters.AddWithValue("@isPaRes", sIsPA);
            objCommand.Parameters.AddWithValue("@antMatriTerm", sAntMT);
            objCommand.Parameters.AddWithValue("@antTUMaj", majorID);

            objCommand.Parameters.AddWithValue("@entryText", entryText);

            //update these when Session is implemented         
            objCommand.Parameters.AddWithValue("@matriculationTerm", "NA");
            if (objDB.DoUpdateUsingCmdObj(objCommand) != -1)
            {
                return true;
            }

            return false;
        }

        public bool manuallyAddStudent(string sLast, string sFirst, string sEmail, string sPhone,
            string sCurI, string sCurM, string sAntT, string sAssS,
            string sIsPA, string sAntMT, string AntTUM, string updatedBy)
        {
            int majorID = 0;
            Int32.TryParse(AntTUM, out majorID);

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "ManuallyAddStudent";
            objCommand.Parameters.AddWithValue("@stuLastName", sLast);
            objCommand.Parameters.AddWithValue("@stuFirstName", sFirst);
            objCommand.Parameters.AddWithValue("@stuEmail", sEmail);
            objCommand.Parameters.AddWithValue("@stuPhone", sPhone);
            objCommand.Parameters.AddWithValue("@curInst", sCurI);
            objCommand.Parameters.AddWithValue("@curMaj", sCurM);
            objCommand.Parameters.AddWithValue("@antTranCred", sAntT);
            objCommand.Parameters.AddWithValue("@assoStat", sAssS);
            objCommand.Parameters.AddWithValue("@initContDa", DateTime.Today.ToShortDateString());
            objCommand.Parameters.AddWithValue("@lastCont", DateTime.Today.ToShortDateString());
            objCommand.Parameters.AddWithValue("@hasMatri", "No");
            objCommand.Parameters.AddWithValue("@isPaRes", sIsPA);
            objCommand.Parameters.AddWithValue("@antMatriTerm", sAntMT);
            objCommand.Parameters.AddWithValue("@antTUMaj", majorID);

            //update these when Session is implemented
            objCommand.Parameters.AddWithValue("@lastUpdatedBy", updatedBy);
            objCommand.Parameters.AddWithValue("@matriculationTerm", "NA");

            if (objDB.DoUpdateUsingCmdObj(objCommand) != -1)
            {
                return true;
            }

            return false;
        }

        public Boolean updateEmail(string eSubject, string eBody, string dateAdded, int isDisabled, int id)
        {

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "updateEmail";
            objCommand.Parameters.AddWithValue("@emailSubject", eSubject);
            objCommand.Parameters.AddWithValue("@emailBody", eBody);
            objCommand.Parameters.AddWithValue("@dateAdded", dateAdded);
            objCommand.Parameters.AddWithValue("@isDisabled", isDisabled);
            objCommand.Parameters.AddWithValue("@ID", id);
            if (objDB.DoUpdateUsingCmdObj(objCommand) != -1)
            {
                return true;
            }

            return false;
        }

        public DataSet getEmail()
        {
            DataSet ds = null;
      
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getEmail";          
            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }


        public void sendEmail(String recipient, String sender, String subject, String body)
        {
            email.SendMail(recipient, sender, subject, body, "", "");

        }

        public DataSet getStudentTableInfo()
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getStudentInfo";
            //objCommand.Parameters.AddWithValue("@studentName", studentname);
            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public DataSet getInactiveStudents()
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetInactiveStudents";
            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public DataSet getMatriculatedStudents()
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetMatriculatedStudents";
            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public string GetIsMatriculated(int studentID)
        {
           

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetIsMatriculated";
            objCommand.Parameters.AddWithValue("@studentID", studentID);
            objDB.GetDataSetUsingCmdObj(objCommand);

            return objDB.GetField("hasMatriculated", 0).ToString();
        }

        public void disableStudent(int studentID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "DisableStudent";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void matriculateStudent(int studentID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "updateHasMatriculated";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void updateMatriculationTerm(int studentID, string matriculationterm)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "updateMatriculationTerm";
            objCommand.Parameters.AddWithValue("@studentID", studentID);
            objCommand.Parameters.AddWithValue("@matriculationTerm", matriculationterm);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void deleteStudent(int studentID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "DeleteStudent";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void restoreStudent(int studentID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "RestoreStudent";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public DataSet getMajorInfo()
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getMajorInfo";
           
            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public DataSet getActiveMajors()
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetActiveMajors";

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }



        public DataSet getAdminInfo()
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getAdminInfo";

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public void updateAdminStatus(int TUID, string adminStatus)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "UpdateAdminStatus";
            objCommand.Parameters.AddWithValue("@TUID", TUID);
            objCommand.Parameters.AddWithValue("@adminStatus", adminStatus);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void updateAdminAccess(int TUID, string adminAccess)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "UpdateAdminAccess";
            objCommand.Parameters.AddWithValue("@TUID", TUID);
            objCommand.Parameters.AddWithValue("@adminAccess", adminAccess);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void updateMajorStatus(int majorID, string majorStatus)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "updateMajorStatus";
            objCommand.Parameters.AddWithValue("@majorID", majorID);
            objCommand.Parameters.AddWithValue("@status", majorStatus);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void updateMajorDescription(int majorID, string majorDescription)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "updateMajorDescription";
            objCommand.Parameters.AddWithValue("@majorID", majorID);
            objCommand.Parameters.AddWithValue("@majorDescription", majorDescription);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void deleteMajor(int majorID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "DeleteMajor";
            objCommand.Parameters.AddWithValue("@majorID", majorID);
           
            objDB.DoUpdateUsingCmdObj(objCommand);
        }


        //pulls all infomation on a single student
        public DataSet getStudentInformation(int studentID)
        {
            
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetStudentInformation";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            ds = objDB.GetDataSetUsingCmdObj(objCommand);
           
            return ds;
        }

        //returns the ID for a given major description
        public int getMajorID(string majorDescription)
        {
            int majorID = 0;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetMajorID";
            objCommand.Parameters.AddWithValue("@majorDescription", majorDescription);
            objDB.GetDataSetUsingCmdObj(objCommand);
           
            Int32.TryParse(objDB.GetField("majorID", 0).ToString(), out majorID);

            return majorID;
        }

        //updates student information
        public void updateStudentInformation(int studentID, string studentLastName, string studentFirstName, string studentEmail, string studentPhone, string currentInstitution, string currentMajor, string transferCredits, string associateStatus, string hasMatriculated, string isPAResident, string anticipatedMatriculationTerm, int anticipatedTUMajor, string lastUpdatedByAdmin)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "UpdateStudentInformation";
            objCommand.Parameters.AddWithValue("@studentID", studentID);
            objCommand.Parameters.AddWithValue("@studentLastName", studentLastName);
            objCommand.Parameters.AddWithValue("@studentFirstName", studentFirstName);
            objCommand.Parameters.AddWithValue("@studentEmail", studentEmail);
            objCommand.Parameters.AddWithValue("@studentPhone", studentPhone);
            objCommand.Parameters.AddWithValue("@currentInstitution", currentInstitution);
            objCommand.Parameters.AddWithValue("@currentMajor", currentMajor);
            objCommand.Parameters.AddWithValue("@anticipatedTransferCredits", transferCredits);
            objCommand.Parameters.AddWithValue("@associateStatus", associateStatus);
            objCommand.Parameters.AddWithValue("@hasMatriculated", hasMatriculated);
            objCommand.Parameters.AddWithValue("@isPAResident", isPAResident);
            objCommand.Parameters.AddWithValue("@anticipatedMatriculationTerm", anticipatedMatriculationTerm);
            objCommand.Parameters.AddWithValue("@anticipatedTUMajor", anticipatedTUMajor);
            objCommand.Parameters.AddWithValue("@lastContacted", DateTime.Today.ToShortDateString());
            objCommand.Parameters.AddWithValue("@lastUpdatedBy", lastUpdatedByAdmin);

            objDB.DoUpdateUsingCmdObj(objCommand);


        }

        //gets all conversation entries for a given student
        public DataSet getEntries(int studentID)
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetEntries";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        //adds a conversation entry for a student
        public void addEntry(int studentID, string contactType, string dateAdded, string entryText, string addedBy)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "AddEntry";
            objCommand.Parameters.AddWithValue("@studentID", studentID);
            objCommand.Parameters.AddWithValue("@contactType", contactType);
            objCommand.Parameters.AddWithValue("@dateAdded", dateAdded);
            objCommand.Parameters.AddWithValue("@entryText", entryText);
            objCommand.Parameters.AddWithValue("@addedBy", addedBy);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        //updates a conversation entry for a student
        public void updateEntry(int entryID, string entryText)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "UpdateEntry";
            objCommand.Parameters.AddWithValue("@entryID", entryID);
            objCommand.Parameters.AddWithValue("@entryText", entryText);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        //deletes a conversation entry
        public void deleteEntry(int entryID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "DeleteEntry";
            objCommand.Parameters.AddWithValue("@entryID", entryID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        //adds conversation entry to export table
        public void addEntryExport(string StudID, int studentID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "addEntryExport";
            objCommand.Parameters.AddWithValue("@StudID", StudID);
            //objCommand.Parameters.AddWithValue("@GenFileNts", GenFileNts);
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void addAdmin(int id, string accessnetID, string lastname, string firstname,string level, string dateadded, string adminstatus, string lastupdateby)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "AddAdmin";
            objCommand.Parameters.AddWithValue("@tuid", id);
            objCommand.Parameters.AddWithValue("@accessnetid", accessnetID);
            objCommand.Parameters.AddWithValue("@lastname", lastname);
            objCommand.Parameters.AddWithValue("@firstname", firstname);
            objCommand.Parameters.AddWithValue("@accesslevel", level);
            objCommand.Parameters.AddWithValue("@dateadded", dateadded);
            objCommand.Parameters.AddWithValue("@adminstatus", adminstatus);
            objCommand.Parameters.AddWithValue("@lastupdatedby", lastupdateby);
            

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void deleteAdmin(int TUID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "DeleteAdmin";
            objCommand.Parameters.AddWithValue("@TUID", TUID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public void addMajor(string description, string status, string lastupdatedby)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "addMajor";
            objCommand.Parameters.AddWithValue("@majordescription", description);
            objCommand.Parameters.AddWithValue("@majorstatus", status);
            objCommand.Parameters.AddWithValue("@dateadded", System.DateTime.Today.ToShortDateString());
            objCommand.Parameters.AddWithValue("@lastupdatedby", lastupdatedby);
           

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public DataSet getDocuments(int studentID)
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetDocuments";
            objCommand.Parameters.AddWithValue("@studentID", studentID);

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public void uploadDocument(string documentName, string documentCategory, byte[] fileData, int studentID, string addedBy)
        {
            string dateUploaded = DateTime.Today.ToShortDateString();

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "uploadFile";
            objCommand.Parameters.AddWithValue("@documentName", documentName);
            objCommand.Parameters.AddWithValue("@documentCategory", documentCategory);
            objCommand.Parameters.AddWithValue("@dateUploaded", dateUploaded);
            objCommand.Parameters.AddWithValue("@fileData", fileData);
            objCommand.Parameters.AddWithValue("@studentID", studentID);
            objCommand.Parameters.AddWithValue("@addedByAdmin", addedBy);
            //objCommand.Parameters.AddWithValue("@documentType", contenttype);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public DataSet getDocument(int documentID)
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetDocument";
            objCommand.Parameters.AddWithValue("@documentID", documentID);

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            return ds;
        }

        public void deleteDocument(int documentID)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "deleteFile";
            objCommand.Parameters.AddWithValue("@documentID", documentID);

            objDB.DoUpdateUsingCmdObj(objCommand);
        }

        public Boolean AdminLogin(string TuID)
        {
            SqlCommand myCommand = new SqlCommand();
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "getAdminInfo";
            DataSet AllAdmin = objDB.GetDataSetUsingCmdObj(myCommand);
            if (AllAdmin.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dtRow in AllAdmin.Tables[0].Rows)
                {
                    string getTUID = dtRow["accessNetID"].ToString();
                    if (getTUID == TuID)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        public string getAccessLevel(string accessnet)
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetAccessLevel";
            objCommand.Parameters.AddWithValue("@accessNetID", accessnet);

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            string accesslevel = ds.Tables[0].Rows[0]["accessLevel"].ToString();

            return accesslevel;
        }

        public string getAdminStatus(string accessnet)
        {
            DataSet ds = null;

            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetAdminStatus";
            objCommand.Parameters.AddWithValue("@accessNetID", accessnet);

            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            string adminStatus = ds.Tables[0].Rows[0]["adminStatus"].ToString();

            return adminStatus;
        }

    }
}
