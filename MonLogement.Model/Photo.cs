using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.Model
{
    public class Photo
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public bool Defaut { get; set; }
        public Ad Ad { get; set; }
        public byte Image { get; set; }
    }
}
