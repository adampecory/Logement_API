using MonLogement.DAL.Repository;
using MonLogement.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;



namespace MonLogement.Api.Controllers
{
    public class RolesController : ApiController
    {
        RoleRepository repo = new RoleRepository();
        //
        // GET: /api/roles
        /// <summary>
        /// Retourne la liste des roles
        /// </summary>
        /// <returns></returns>
        public IEnumerable<Role> GetAllRoles()
        {
            return repo.GetAll();
        }

        public IHttpActionResult Post([FromBody]Role role)
        {
            if (role!=null && !string.IsNullOrEmpty(role.Name))
            {
                repo.Add(role);
                return StatusCode(HttpStatusCode.Created);
            }
            else
            {
                return BadRequest("Le nom du role est obligatoire");
            }
        }

        public IHttpActionResult Put(long id, [FromBody]Role role)
        {
            repo.Update(id, role);
            return Ok(role);
        }

        public IHttpActionResult Delete(long id)
        {
            if (id>0)
            {
                repo.Delete(id);
                return StatusCode(HttpStatusCode.NoContent);
            }
            else
            {
                return BadRequest("Paramètre incorrect");
            }
        }

        [ResponseType(typeof(Role))]
        public IHttpActionResult Get(long id)
        {
            if (id > 0)
            {
                var role = repo.GetbyId(id);
                if (role != null)
                    return Ok(role);
                else 
                    return StatusCode(HttpStatusCode.NotFound);
            }
            else
            {
                return BadRequest("Paramètre incorrect");
            }
        }

        [HttpGet]
        [Route("api/roles/name/{name}", Name = "GetRoleByName")]
        [ResponseType(typeof(Role))]
        public IHttpActionResult Get(string name)
        {
            if (!string.IsNullOrEmpty(name))
            {
                var role = repo.GetbyName(name);
                if (role != null)
                    return Ok(role);
                else
                    return StatusCode(HttpStatusCode.NotFound);
            }
            else
            {
                return BadRequest("Paramètre incorrect");
            }
        }
	}
}