using MonLogement.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.DAL.Interface
{
    public interface IUserRepository : IRepositoty<User>
    {
         User GetbyLogin(string login);
         User ValidateUser(string login, string password);
         User UpdatePassword(long userId, string oldPassword, string newPassword);

         IEnumerable<Role> GetRolesbyUser(long userId);
         IEnumerable<User> GetUsersbyRole(long roleId);
         void AddUserToRole(long userId, long roleId);
         void RemoveUserToRole(long userId, long roleId);

    }
}
