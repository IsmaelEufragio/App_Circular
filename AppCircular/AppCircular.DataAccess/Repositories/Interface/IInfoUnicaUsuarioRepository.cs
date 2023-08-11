using AppCircular.Common.Models.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IInfoUnicaUsuarioRepository<T>
    {
        public Task<IEnumerable<T>> ListAsync();
        public Task<int> InsertAsync(T item);
        public Task<int> UpdateAsync(int Id, InfoUnicaUsuarioViewModel item);
    }
}
