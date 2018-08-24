using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UsedPartsDepot
{
    public partial class _Default : Page
    {
        //formats the json returned from car query to a propper json format
        public string formater(string json)
        {
            json = json.Substring(2, json.Length - 4);
            return json;
        }

        public string Get(string uri)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            request.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (Stream stream = response.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                return reader.ReadToEnd();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //populate years drop down list using carqueryapi json
         
            if (!IsPostBack)
            {
                //get the minimum and maximum car years available in json
                string Json_MinMaxYears = formater(Get("https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getYears"));
                //convert to a more usable object for querying
                dynamic dynJson = JsonConvert.DeserializeObject(Json_MinMaxYears);

                //query out the min and max years
                int max_year = dynJson.Years.max_year;
                int min_year = dynJson.Years.min_year;

                //loop from biggest year to smallest year and add it to a drop down list control
                for (int i = max_year; i >= min_year; i--)
                {
                    ddlYear.Items.Add(i.ToString());
                }

            }

            
            ClientScript.GetPostBackEventReference(this, string.Empty);

            //get postback control 
            string targetCtrl = Page.Request.Params.Get("__EVENTTARGET");
            //check if control is a subcategory menu control 'SubCat' 
            if (targetCtrl != null && targetCtrl != string.Empty && targetCtrl.Contains("SubCat"))
            {
                GetPostBackControlName();
            }

        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlMake.Visible = true;
            ddlMake.Items.Clear();

            ddlModel.Items.Clear();
            ddlModel.Visible = false;
            ddlTrim.Visible = false;
            

            string Json_Makes = formater(Get("https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getMakes&year=" + ddlYear.SelectedItem.ToString() + "&sold_in_us=1"));

            dynamic dynJson = JsonConvert.DeserializeObject(Json_Makes);
            int count = 0;
            foreach (var item in dynJson.Makes)
            {

                ddlMake.Items.Add((string)item.make_display);
                count++;
            }


        }

        protected void ddlMake_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlModel.Visible = true;
            ddlModel.Items.Clear();

            ddlTrim.Visible = false;
           


            string year = ddlYear.SelectedItem.ToString();
            string make = ddlMake.SelectedItem.ToString();
            string Json_Models = formater(Get("https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getModels&make=" + make + "&year=" + year + "&sold_in_us=1"));

            dynamic dynJson = JsonConvert.DeserializeObject(Json_Models);
            int count = 0;
            foreach (var item in dynJson.Models)
            {

                ddlModel.Items.Add((string)item.model_name);
                count++;
            }



        }

        protected void ddlModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlTrim.Visible = true;
            ddlTrim.Items.Clear();

            string year = ddlYear.SelectedItem.ToString();
            string make = ddlMake.SelectedItem.ToString();
            string model = ddlModel.SelectedItem.ToString();

            string Json_Trim = formater(Get("https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getTrims&make=" + make + "&model=" + model + "&year=" + year));
            dynamic dynJson = JsonConvert.DeserializeObject(Json_Trim);

            if(Enumerable.Count(dynJson.Trims) != 0)
            {
                foreach (var item in dynJson.Trims)
                {
                    ddlTrim.Items.Add((string)item.model_trim);
                }
            }
            else
            {
                ddlTrim.Items.Add("N/A");
            }
         

        }

        protected void ddlTrim_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void btnMainCategory_Click(object sender, ImageClickEventArgs e)
        {
            mvPartsSelection.ActiveViewIndex = 1;
            ImageButton btnClicked = (ImageButton)sender;
            string btn = btnClicked.ID.Substring(3);

            dynamic jsonMenu = JsonConvert.DeserializeObject(File.ReadAllText(Server.MapPath("App_Data/MenuJson.txt")));

            if(btn == "Tires")
            {
                //do stuff here
            }
            else
            {
                lstSubCategories.Items.Clear();

                foreach (var item in jsonMenu[btn])
                {
                    lstSubCategories.Items.Add(new ListItem((string)item));
                }
            }
          
            
        }

        protected void btnBackCategory_Click(object sender, EventArgs e)
        {
            mvPartsSelection.ActiveViewIndex = 0;
        }

        private string GetPostBackControlName()
        {
            string Output = "";
            //get the __EVENTTARGET of the Control that cased a PostBack(except Buttons and ImageButtons)
            string targetCtrl = Page.Request.Params.Get("__EVENTTARGET");

            //remove MainContent_
            Output = targetCtrl.Substring(12);
            //remove SubCat
            Output = Output.Substring(0, Output.Length - 6);
            //Output Name
            return Output;
        }
    }
}