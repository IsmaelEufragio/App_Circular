using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class CategoriaService : ICategoriaService
    {
        private readonly ICategoriaRepository _categoriaRepository;

        public CategoriaService(ICategoriaRepository categoriaRepository)
        {
            _categoriaRepository = categoriaRepository;
        }

        public async Task<IEnumerable<CategoriaNegociosDTO>> CategoriaNegociosAsync()
        {
            var categorias = await _categoriaRepository.GetAllAsync();
            return categorias.Select(a => new CategoriaNegociosDTO
            {
                Id = a.catg_Id,
                Descripcion = a.catg_Nombre
            });
        }
    }
}
