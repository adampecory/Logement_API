using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.DAL.Interface
{
    public interface IRepositoty<T> where T: class
    {
         IEnumerable<T> GetAll();
         void Add(T obj);
         void Delete(long id);
         T Update(long id, T role);
         T GetbyId(long id);
         T GetbyName(string name);
    }
}
