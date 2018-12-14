using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CLATransferSupportSystem
{
    /// <summary>
    /// Class to create an LDAP User.  Also, due to the lack of Faculty Web service calls, this will be the primary object for
    /// Faculty Login
    /// </summary>
    public class LDAPuser
    {
        public string templeEduID;
        public string uID;
        public string cn;
        public string givenName;
        public string sn;
        public string eduPersonAffiliation;
        public string eduPersonPrimaryAffiliation;
        public string mail;
        public string title;
    }

    /// <summary>
    /// Class for identifying Term
    /// </summary>
    public class Term
    {
        public string termCode;
        public string termName;
        public string startDate;
        public string endDate;
        public string registrationStartDate;
        public string registrationEndDate;
    }

    /// <summary>
    /// Student Object 
    /// </summary>
    public class StudentObj
    {
        public string firstName { get; set; }
        public string middleInit { get; set; }
        public string lastName { get; set; }
        public string tuid { get; set; }
        public string email { get; set; }
        public string school { get; set; }
        public string major1 { get; set; }
        public string major2 { get; set; }

        public StudentObj() { }

        //Big ol' constructor
        public StudentObj(string firstName, string middleInit, string lastName, string tuid, string email, string school, string major1, string major2)
        {
            this.firstName = firstName;
            this.middleInit = middleInit;
            this.lastName = lastName;
            this.tuid = tuid;
            this.email = email;
            this.school = school;
            this.major1 = major1;
            this.major2 = major2;
        }
    }

    /// <summary>
    /// Class to hold College Info
    /// </summary>
    public class College
    {
        public string collegeName;
        public string collegeCode;
    }
}