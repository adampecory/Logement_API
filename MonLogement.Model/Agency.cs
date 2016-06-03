using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.Model
{
    public class Agency
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Responsible { get; set; }
        public string Tel { get; set; }
        public string Email { get; set; }
        public string Logo { get; set; }

        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }

        public IEnumerable<User> User { get; set; }

    }
}
