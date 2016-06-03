using MonLogement.DAL.Interface;
using MonLogement.DAL.Tools;
using MonLogement.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.DAL.Repository
{
    public class RoleRepository : IRoleRepository
    {
        public IEnumerable<Role> GetAll()
        {
            string procname = "spRoleGet";
            DataTable DT = Database.ExcecuteReader(procname);
            var roles = GetRoles(DT);
            return roles;
        }

        public void Add(Role role)
        {
            string procname = "spRoleAdd";
            var pName = new SqlParameter("@Name", role.Name);
            Database.ExcecuteNonQuery(procname, new SqlParameter[] { pName });
        }

        public void Delete(long id)
        {
            var procname = "spRoleDelete";
            var pId = new SqlParameter("@Id", id);
            Database.ExcecuteNonQuery(procname, new SqlParameter[] { pId });
        }

        public Role Update(long id, Role role)
        {
            string procname = "spRoleUpdate";
            var pId = new SqlParameter("@Id", id);
            var pName = new SqlParameter("@Name", role.Name);
            Database.ExcecuteNonQuery(procname, new SqlParameter[] { pId, pName });
            return role;
        }

        public Model.Role GetbyId(long id)
        {
            string procname = "spRoleGetbyId";
            var pId = new SqlParameter("@Id", id);
            DataTable DT = Database.ExcecuteReader(procname, new SqlParameter[] { pId });
            var roles = GetRoles(DT);
            return roles[0];
        }

        public Model.Role GetbyName(string name)
        {
            string procname = "spRoleGetbyName";
            var pId = new SqlParameter("@Name", name);
            DataTable DT = Database.ExcecuteReader(procname, new SqlParameter[] { pId });
            var roles = GetRoles(DT);
            return roles[0];
        }

        /// <summary>
        /// Retourne une liste de role à partir d'un DATATABLE
        /// </summary>
        /// <param name="DT">Datatable</param>
        /// <returns></returns>
        private List<Role> GetRoles(DataTable DT)
        {
            List<Role> roles = new List<Role>();
            foreach (DataRow row in DT.Rows)
            {
                roles.Add(new Role { Id = int.Parse(row["Id"].ToString()), Name = row["Name"].ToString() });
            }
            return roles;
        } 
    }
}
