using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.Model
{
    public class Ad
    {
        public long Id { get; set; }
        public decimal Price { get; set; }
        public decimal Surface { get; set; }
        public int NbRoom { get; set; }
        public int NbBedRoom { get; set; }
        public int NbBathRoom { get; set; }

        public AdType AdType { get; set; }
        public OperationType SearchType { get; set; }
        public User User { get; set; }
        public Locality Locality { get; set; }

        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
        public DateTime ExpirededDate { get; set; }
        public bool IsValidate { get; set; }
        public DateTime ValidatedDate { get; set; }

        
    }
}
