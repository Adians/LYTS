using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TCS.Web.viewModel
{
    public class StatisticsByDayModel
    {
        public string name { get; set; }
        public string id { get; set; }
        public List<DayAndSum> data { get; set; }
    }
}