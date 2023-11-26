using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories
{
    public class InfoUnicaUsuarioRepository : IInfoUnicaUsuarioRepository<tbInfoUnicaUsuario>
    {
        public async Task<int> InsertAsync(tbInfoUnicaUsuario item)
        {
            try
            {
                using var db = new AppCircularContext();
                db.tbInfoUnicaUsuario.Add(item);
                var serult = await db.SaveChangesAsync();
                return serult;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public async Task<IEnumerable<tbInfoUnicaUsuario>> ListAsync()
        {
            using var db = new AppCircularContext();
            return await db.tbInfoUnicaUsuario.ToListAsync();
        }

        public async Task<int> UpdateAsync(Guid Id, InfoUnicaUsuarioViewModel item)
        {
            using var db = new AppCircularContext();
            var userinfo = await db.tbInfoUnicaUsuario.SingleOrDefaultAsync(a => a.usInf_Id == Id);

            if (userinfo != null)
            {
                userinfo.usInf_Nombre = item.Nombre;
                userinfo.usInf_RutaLogo = item.RutaLogo;
                userinfo.usInf_RutaPaginaWed = item.RutaPaginaWed;
                userinfo.usInf_RutaLogo = item.RutaLogo;
                userinfo.tipUs_Id = item.tipUs_Id;
                await db.SaveChangesAsync();
                return 1;
            }
            return 0;
        }
    }
}
