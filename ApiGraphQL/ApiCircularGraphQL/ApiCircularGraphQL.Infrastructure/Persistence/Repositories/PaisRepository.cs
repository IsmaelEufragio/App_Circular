using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Infrastructure.Persistence.Repositories
{
    public class PaisRepository : Repository<tbPais>, IPaisRepository
    {
        private readonly AppECOContext _context;
        public PaisRepository( AppECOContext context): base(context)
        {
            _context = context;
        }
        public async Task<List<tbPais>> GetPedidosByPaisIdAsync(Guid idPais)
        {
            return await _context.tbPais.Where(a=> a.pais_Id == idPais).ToListAsync();
        }
    }
}
