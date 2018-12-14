using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;

namespace CLATransferSupportSystem
{


    public partial class Login : System.Web.UI.Page
    {
        private static string webServiceUsername = ConfigurationManager.AppSettings["webServiceUsername"];
        private static string webServicePassword = ConfigurationManager.AppSettings["webServicePassword"];

        protected void Page_Load(object sender, EventArgs e)
        {

            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                Session.Clear();
                Session.RemoveAll();
                Session.Abandon();

        }

    }



        protected void btnLogin_Click(object sender, EventArgs e)
        {

            if (String.IsNullOrEmpty(txtUsername.Text))
            {
                lblText.Text = "Error: username cannot be blank";
            }

            else if (String.IsNullOrEmpty(txtPassword.Text))
            {
                lblText.Text = "Error: password cannot be blank";
            }

            else
            {
                Boolean test = AuthenticateUser(txtUsername.Text, txtPassword.Text);
                if (test == false)
                {
                    lblText.Text = "Error: invalid username/password";
                }
                else
                {


                    StoredProcedure sp1 = new StoredProcedure();
                    if (sp1.AdminLogin(txtUsername.Text) == true)
                    {
                        if (sp1.getAdminStatus(txtUsername.Text) == "Active")
                        {
                            LDAPuser user = new LDAPuser();
                            user = getLDAPEntryByAccessnet(txtUsername.Text);


                            Session["UserName"] = txtUsername.Text; //accessnet username
                            Session["AccessLevel"] = sp1.getAccessLevel(txtUsername.Text); //access level
                            Session["firstName"] = user.givenName; //first name
                            Session["lastName"] = user.sn; //last name
                            Session["tuid"] = user.templeEduID; //tuid

                            Response.Redirect("AdvisorDashboard.aspx");
                        }
                        else 
                        {
                            lblText.Text = "Error: Account deactivated";
                        }


                    }
                    else
                    {
                        lblText.Text = "Error: Not a registered user";
                    }
                }
            }
        }

        public static bool AuthenticateUser(string strUID, string strPassword)
        {
            string strID = string.Empty;
            var entry = new DirectoryEntry();

            try
            {
                // call getDNFRromLDAP method to anonymously (port 389)
                // search against ldap for the correct DN
                string strDN = getDNFromLDAP(strUID);

                //now use the found DN for the secure bind (port 636)
                entry.Path = "LDAP://rock.temple.edu/" + strDN;
                entry.Username = strDN;
                entry.Password = strPassword;
                entry.AuthenticationType = AuthenticationTypes.SecureSocketsLayer;

                //try to fetch a property..if no errors raised then it works
                strID = entry.Properties["sAMAccountName"][0].ToString();

            }
            catch
            {
                return false;
            }
            finally
            {
                entry.Close();
                entry.Dispose();
            }
            return true;
        }


        public static string getDNFromLDAP(string strUID)
        {
            var entry = new DirectoryEntry("LDAP://rock.temple.edu/ou=temple,dc=tu,dc=temple,dc=edu");
            entry.AuthenticationType = AuthenticationTypes.None;
            var mySearcher = new DirectorySearcher(entry);
            entry.Close();
            entry.Dispose();
            mySearcher.Filter = "(sAMAccountName=" + strUID + ")";
            var result = mySearcher.FindOne();
            mySearcher.Dispose();
            int nIndex = result.Path.LastIndexOf("/");
            string strDN = result.Path.Substring((nIndex + 1)).ToString().TrimEnd();
            return strDN;
        }


        /// <summary>
        /// Creates a LDAPuser (Person Object) when passing a TUID
        /// </summary>
        /// <param name="tuID">TUID</param>
        /// <returns>LDAPuser</returns>
        public static LDAPuser getLDAPEntryByTUID(string tuID)
        {
            // Create the WebService proxy, send the search request and receive the TempleLDAPEntry object
            WS_LDAPSearch.LDAP_Search ldapProxy = new WS_LDAPSearch.LDAP_Search();
            WS_LDAPSearch.TempleLDAPEntry[] results = new WS_LDAPSearch.TempleLDAPEntry[1];
            results = ldapProxy.Search(webServiceUsername, webServicePassword, "templeEduTUID", tuID);
            WS_LDAPSearch.TempleLDAPEntry resultEntry = results[0];

            // Check if request was successful
            if (resultEntry.error == null) // Success
            {
                // Create our TempleLDAPEntry object to be returned
                LDAPuser personLDAPEntry = new LDAPuser();
                personLDAPEntry.templeEduID = resultEntry.templeEduTUID;
                personLDAPEntry.uID = resultEntry.uid;
                personLDAPEntry.cn = resultEntry.cn;
                personLDAPEntry.givenName = resultEntry.givenName;
                personLDAPEntry.sn = resultEntry.sn;
                personLDAPEntry.eduPersonAffiliation = resultEntry.eduPersonAffiliation;
                personLDAPEntry.eduPersonPrimaryAffiliation = resultEntry.eduPersonPrimaryAffiliation;
                personLDAPEntry.mail = resultEntry.mail;
                personLDAPEntry.title = resultEntry.title;
                return personLDAPEntry;
            }
            else // Something went wrong..
            {
                return null;
            }
        }

        /// <summary>
        /// Takes in an accessnet and returns an LDAPuser (Person Object) based on that AccessnetID
        /// </summary>
        /// <param name="accessnetID"></param>
        /// <returns>LDAPuser</returns>
        public static LDAPuser getLDAPEntryByAccessnet(string accessnetID)
        {
            // Create the WebService proxy, send the search request and receive the TempleLDAPEntry object
            WS_LDAPSearch.LDAP_Search ldapProxy = new WS_LDAPSearch.LDAP_Search();
            WS_LDAPSearch.TempleLDAPEntry[] results = new WS_LDAPSearch.TempleLDAPEntry[1];
            results = ldapProxy.Search(webServiceUsername, webServicePassword, "uid", accessnetID);
            WS_LDAPSearch.TempleLDAPEntry resultEntry = results[0];

            // Check if request was successful
            if (resultEntry.error == null) // Success
            {
                // Create our TempleLDAPEntry object to be returned
                LDAPuser personLDAPEntry = new LDAPuser();
                personLDAPEntry.templeEduID = resultEntry.templeEduTUID;
                personLDAPEntry.uID = resultEntry.uid;
                personLDAPEntry.cn = resultEntry.cn;
                personLDAPEntry.givenName = resultEntry.givenName;
                personLDAPEntry.sn = resultEntry.sn;
                personLDAPEntry.eduPersonAffiliation = resultEntry.eduPersonAffiliation;
                personLDAPEntry.eduPersonPrimaryAffiliation = resultEntry.eduPersonPrimaryAffiliation;
                personLDAPEntry.mail = resultEntry.mail;
                personLDAPEntry.title = resultEntry.title;
                return personLDAPEntry;
            }
            else // Something went wrong..
            {
                return null;
            }
        }

        /// <summary>
        /// Takes in an Email and returns a LDAP Object(Person Object) of that User
        /// </summary>
        /// <param name="emailAlias"></param>
        /// <returns>LDAPuser</returns>
        public static LDAPuser getLDAPEntryByEmailAlias(string emailAlias)
        {
            // Split the email address and get the contents before the @
            string[] splitEmailAlias = emailAlias.Split('@');
            string templeEduTUNA = splitEmailAlias[0];

            // Create the WebService proxy, send the search request and receive the TempleLDAPEntry object
            WS_LDAPSearch.LDAP_Search ldapProxy = new WS_LDAPSearch.LDAP_Search();
            WS_LDAPSearch.TempleLDAPEntry[] results = new WS_LDAPSearch.TempleLDAPEntry[1];
            results = ldapProxy.Search(webServiceUsername, webServicePassword, "templeEduTUNA", templeEduTUNA);
            WS_LDAPSearch.TempleLDAPEntry resultEntry = results[0];

            // Check if request was successful
            if (resultEntry.error == null) // Success
            {
                // Create our TempleLDAPEntry object to be returned
                LDAPuser personLDAPEntry = new LDAPuser();
                personLDAPEntry.templeEduID = resultEntry.templeEduTUID;
                personLDAPEntry.uID = resultEntry.uid;
                personLDAPEntry.cn = resultEntry.cn;
                personLDAPEntry.givenName = resultEntry.givenName;
                personLDAPEntry.sn = resultEntry.sn;
                personLDAPEntry.eduPersonAffiliation = resultEntry.eduPersonAffiliation;
                personLDAPEntry.eduPersonPrimaryAffiliation = resultEntry.eduPersonPrimaryAffiliation;
                personLDAPEntry.mail = resultEntry.mail;
                personLDAPEntry.title = resultEntry.title;
                return personLDAPEntry;
            }
            else // Something went wrong..
            {
                return null;
            }
        }

        /// <summary>
        /// Gets the Current Term of the Current Date
        /// </summary>
        /// <returns>Term Object</returns>
        public static Term getCurrentTerm()
        {
            WS_StudentSearch.WS_Student studentProxy = new WS_StudentSearch.WS_Student();
            WS_StudentSearch.Result results = new WS_StudentSearch.Result();
            results = studentProxy.GetCurrentTerm(webServiceUsername, webServicePassword);

            // Check if request was successful
            if (results.Status == "OK") // Success
            {
                Term returnTerm = new Term();
                WS_StudentSearch.Term[] t = results.Terms;
                returnTerm.termCode = t[0].code;
                returnTerm.termName = t[0].name;
                returnTerm.startDate = t[0].startDate;
                returnTerm.endDate = t[0].endDate;

                return returnTerm;
            }
            else // Something went wrong...
            {
                return null;

            }
        }

        /// <summary>
        /// Takes in a Terms Code and returns the Term Object associated with it
        /// </summary>
        /// <param name="termCode"></param>
        /// <returns>Term Object</returns>
        public static Term getTermByTermCode(string termCode)
        {
            WS_StudentSearch.WS_Student studentProxy = new WS_StudentSearch.WS_Student();
            WS_StudentSearch.Result results = new WS_StudentSearch.Result();
            results = studentProxy.GetTermByTermCode(webServiceUsername, webServicePassword, termCode);

            // Check if request was successful
            if (results.Status == "OK") // Success
            {
                Term returnTerm = new Term();
                WS_StudentSearch.Term[] t = results.Terms;
                returnTerm.termCode = t[0].code;
                returnTerm.termName = t[0].name;
                returnTerm.startDate = DateTime.Parse(t[0].startDate).ToShortDateString().ToString();
                returnTerm.endDate = DateTime.Parse(t[0].endDate).ToShortDateString().ToString();
                return returnTerm;
            }
            else // Something went wrong...
            {
                return null;

            }
        }

        /// <summary>
        /// Takes in a Date and returns the Term it is in
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static Term GetTermByDate(string date)
        {
            WS_StudentSearch.WS_Student studentProxy = new WS_StudentSearch.WS_Student();
            WS_StudentSearch.Result results = new WS_StudentSearch.Result();
            results = studentProxy.GetTermByDate(webServiceUsername, webServicePassword, date);

            // Check if request was successful
            if (results.Status == "OK") // Success
            {
                Term returnTerm = new Term();
                WS_StudentSearch.Term[] t = results.Terms;
                returnTerm.termCode = t[0].code;
                returnTerm.termName = t[0].name;
                returnTerm.startDate = t[0].startDate;
                returnTerm.endDate = t[0].endDate;

                return returnTerm;
            }
            else // Something went wrong...
            {
                return null;

            }
        }

        /// <summary>
        /// Returns an array of all colleges
        /// </summary>
        /// <returns></returns>
        //public static College[] getAllColleges()
        //{
        //try
        //{
        //WS_ProgramsAndDegrees.ProgramsAndDegrees programsProxy = new WS_ProgramsAndDegrees.ProgramsAndDegrees();
        //WS_ProgramsAndDegrees.ProgramsAndDegreesEntry[] results = new WS_ProgramsAndDegrees.ProgramsAndDegreesEntry[30];
        //results = programsProxy.GetAllColleges(webServiceUsername, webServicePassword);

        //College[] colleges = new College[results.Length];

        //for (int i = 0; i < results.Length; i++)
        //{
        //College c = new College();
        //c.collegeName = results[i].college.ToString();
        //c.collegeCode = results[i].collegeCode.ToString();
        //colleges[i] = c;
        //}

        //return colleges;
        //}
        //catch (Exception ex)
        //{
        //return null;
        //}
        //}

        /// <summary>
        /// Takes in a College Code and returns a Name Identified by that Code
        /// </summary>
        /// <param name="collegeCode"></param>
        /// <returns></returns>
        //public static string getCollegeNameByCollegeCode(string collegeCode)
        //{
        //try
        //{
        //WS_ProgramsAndDegrees.ProgramsAndDegrees programsProxy = new WS_ProgramsAndDegrees.ProgramsAndDegrees();
        //WS_ProgramsAndDegrees.ProgramsAndDegreesEntry[] results = new WS_ProgramsAndDegrees.ProgramsAndDegreesEntry[30];
        //results = programsProxy.GetAllColleges(webServiceUsername, webServicePassword);

        //foreach (WS_ProgramsAndDegrees.ProgramsAndDegreesEntry entry in results)
        //{
        //if (entry.collegeCode.Equals(collegeCode))
        //{
        //return entry.college;
        //}
        //}
        //}
        //catch (Exception ex)
        //{
        //return null;
        //}

        //return null;
        //}

        /// <summary>
        /// takes in a TUID and creates a StudentObj with Full name, Email, TUID, Major, and College Code
        /// </summary>
        /// <param name="TUID"></param>
        /// <returns></returns>
        public static StudentObj getStudentInfo(string TUID)
        {
            //////// Get LDAP Info
            StudentObj student = new StudentObj();
            LDAPuser entry = getLDAPEntryByTUID(TUID);

            if (entry != null)
            {
                String[] name = entry.cn.Split(null); // splits 'cn' into first, middle, last

                if (name.Length == 2) // No middle initial
                {
                    student.firstName = name[0];
                    student.middleInit = "";
                    student.lastName = name[1];
                }
                else if (name.Length == 3) // Has middle initial
                {
                    student.firstName = name[0];
                    student.middleInit = name[1];
                    student.lastName = name[2];
                }
                else if (name.Length == 4) // Special case for people with 4 part names
                {
                    student.firstName = name[0];
                    student.middleInit = name[1] + " " + name[2];
                    student.lastName = name[3];
                }

                student.email = entry.mail;
                student.tuid = entry.templeEduID;

                //////// Get Academic Info
                WS_StudentSearch.WS_Student studentProxy = new WS_StudentSearch.WS_Student();
                WS_StudentSearch.Result results = new WS_StudentSearch.Result();
                results = studentProxy.GetAcademicInfoByTUID(webServiceUsername, webServicePassword, TUID);

                // Check if request was successful
                if (results.Status == "OK") // Success
                {
                    WS_StudentSearch.Student[] s = results.Students;
                    student.major1 = s[0].major1;
                    student.major2 = s[0].major2;
                    student.school = s[0].collegeCode;

                }
                else // Something went wrong...
                {
                    return null;
                }
            }

            return student;
        }

        /// <summary>
        /// takes in a faculty TUID and returns a string of the title(ie. Employee, Faculty) they hold
        /// </summary>
        /// <param name="TUID"></param>
        /// <returns>String</returns>
        public static String getFacultyTitleByTUID(string TUID)
        {
            // Create the WebService proxy, send the search request and receive the TempleLDAPEntry object
            WS_LDAPSearch.LDAP_Search ldapProxy = new WS_LDAPSearch.LDAP_Search();
            WS_LDAPSearch.TempleLDAPEntry[] results = new WS_LDAPSearch.TempleLDAPEntry[1];
            results = ldapProxy.Search(webServiceUsername, webServicePassword, "templeEduTUID", TUID);
            WS_LDAPSearch.TempleLDAPEntry resultEntry = results[0];

            // Check if request was successful
            if (resultEntry.error == null) // Success
            {
                string[] affiliations = resultEntry.eduPersonAffiliation.Split(',');
                foreach (string s in affiliations)
                {
                    if (s.Equals("faculty"))
                    {
                        return resultEntry.title;
                    }
                }

                return null;
            }
            else // Something went wrong..
            {
                return null;
            }
        }

    }
}