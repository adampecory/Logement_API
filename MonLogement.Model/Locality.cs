using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.Model
{
    public class Locality
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public int RangeMin { get; set; }
        public int RangeMax { get; set; }
        public int Level { get; set; }

        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
