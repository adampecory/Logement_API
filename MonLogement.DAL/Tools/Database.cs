using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonLogement.DAL.Tools
{
    public static class Database
    {
        public static void ExcecuteNonQuery(string procedureName, SqlParameter[] parameters = null)
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = procedureName;
                    if (parameters != null) cmd.Parameters.AddRange(parameters);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        public static object ExcecuteScalar(string procedureName, SqlParameter[] parameters = null)
        {
            object retour = null;
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = procedureName;
                    if (parameters != null) cmd.Parameters.AddRange(parameters);
                    con.Open();
                    retour = cmd.ExecuteScalar();
                    con.Close();
                }
            }
            return retour;
        }

        /// <summary>
        /// Exécution d'une procédure retournant des données
        /// </summary>
        /// <param name="procedureName">Nom de la procédure</param>
        /// <param name="parameters">Paramètres</param>
        /// <returns></returns>
        public static DataTable ExcecuteReader(string procedureName, SqlParameter[] parameters = null)
        {
            DataTable DT = new DataTable();
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = procedureName;
                    if (parameters != null) cmd.Parameters.AddRange(parameters);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(DT);
                    con.Close();
                }
            }
            return DT;
        }
    }

}
