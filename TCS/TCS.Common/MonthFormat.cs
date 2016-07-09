using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TCS.Common
{
    public static class MonthFormat
    {

        public static string MonthFormatSet(int n)
        {
            string month = "";
            switch (n)
            {
                case 1:
                    month= "一月";
                    break;
                case 2:
                    month = "二月";
                    break;
                case 3:
                    month = "三月";
                    break;
                case 4:
                    month = "四月";
                    break;
                case 5:
                    month = "五月";
                    break;
                case 6:
                    month = "六月";
                    break;
                case 7:
                    month = "七月";
                    break;
                case 8:
                    month = "八月";
                    break;
                case 9:
                    month = "九月";
                    break;
                case 10:
                    month = "十月";
                    break;
                case 11:
                    month = "十一月";
                    break;
                case 12:
                    month = "十二月";
                    break;
                default:
                    month = " ";
                    break;
            }
            return month;

        }
    }
}
