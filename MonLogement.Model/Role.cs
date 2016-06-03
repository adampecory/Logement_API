using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.Model
{
    public class Role
    {
        public long Id { get; set; }
        public string Name { get; set; }

        public IEnumerable<User> User { get; set; }
    }
}
