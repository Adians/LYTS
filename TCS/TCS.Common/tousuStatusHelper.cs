using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TCS.Common
{
    public static class tousuStatusHelper
    {
        public static string tousuStatusFormat(int i) {

            string res = "";
            switch (i)
            {
                case 1:
                    res = "处理中";
                    break;
                case 2:
                    res = "待评价";
                    break;
                case 3:
                    res = "已完结";
                    break;
                default:
                    break;
            }

            return res;
        }
    }
}
