using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Net;
using System.IO;

namespace First_app
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            CurrentValue.Content = "Нет данных на текущее время!";
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            GetCurrentValue getCur = new GetCurrentValue();
            string Content = getCur.getCurrentVal();
            CurrentValue.Content = Content;
        }
    }

    public class GetCurrentValue 
    {
        public string getCurrentVal()
        {
            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://www.cbr-xml-daily.ru/daily.xml");
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://www.cbr-xml-daily.ru/daily_json.js");
    
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            string currentResp = "";
            if (response.StatusCode == HttpStatusCode.Forbidden)
            {
                currentResp = "Нельзя обработать ответ (404)";
            }
            else if (response.StatusCode == HttpStatusCode.OK)
            {
                currentResp = "ХЗ";
                using (StreamReader r = new StreamReader(response))
                {
                    string json = r.ReadToEnd();
                    List<T> items = JsonConvert.DeserializeObject<List<Item>>(json);
                }
                //WebHeaderCollection header = response.Headers;
                //var encoding = ASCIIEncoding.ASCII;
                //using (var reader = new System.IO.StreamReader(response.GetResponseStream(), encoding))
                //{
                //    currentResp = "Ку-ку епта";
                //    string responceText = reader.ReadToEnd();
                //    XDocument xmlDoc = XDocument.Parse(responceText);
                //    var rootXML = xmlDoc.Root;
                //    var valuetElements = rootXML.Elements();
                //    foreach (var strElem in valuetElements)
                //    {
                //        currentResp = strElem.Element("Value").ToString();//LastNode.ToString();
                //    }
                //currentResp = CurrentXML.ToString();
            }
            }

            response.Close();
            return currentResp;
        }
    }
}
