using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Configuracion
{
    public enum ServiceResultType
    {
        //Continue - Indica que el cliente puede continuar con la siguiente parte de la solicitud.
        Continue = 100,
        //OK - La solicitud se ha procesado correctamente.
        Success = 200,
        //Created - La solicitud ha tenido éxito y se ha creado un nuevo recurso como resultado.
        Created = 201,
        //Accepted - La solicitud se ha aceptado para procesarla, pero el resultado aún no está disponible o no es final.
        Warning = 202,
        //No Content - La solicitud se ha procesado correctamente, pero no hay contenido para enviar en la respuesta.
        NoContent = 204,
        //Non-Authoritative Information - Indica que la respuesta es satisfactoria, pero no contiene una representación válida del recurso solicitado.
        NonAuthoritative = 203,

        //Moved Permanently - El recurso solicitado ha sido movido permanentemente a una nueva ubicación.
        MovedPermanently = 301,
        //Found - El recurso solicitado se encuentra temporalmente en una nueva ubicación.
        Found = 302,


        //Bad Request - La solicitud no se pudo entender o faltan parámetros requeridos.
        BadRecuest = 400,//====
        //Unauthorized - El cliente debe autenticarse para obtener la respuesta.
        Unauthorize = 401,
        //Forbidden - El servidor ha entendido la solicitud, pero se niega a autorizarla.
        Forbidden = 403,
        //Not Found - El recurso solicitado no fue encontrado en el servidor.
        NotFound = 404,
        //Not Acceptable - Indica que el servidor no puede producir una respuesta que sea aceptable según los encabezados de aceptación enviados en la solicitud.
        NotAcceptable = 406,
        //Conflict - Indica que la solicitud no pudo ser procesada debido a un conflicto en el estado actual del recurso.
        Conflict = 409,
        //Gone - Indica que el recurso solicitado ya no está disponible en el servidor y no se espera que esté disponible nuevamente en el futuro.
        Disabled = 410,

        //Internal Server Error - Ocurrió un error interno en el servidor al procesar la solicitud.
        Error = 500,
        //Not Implemented - La solicitud no ha sido implementada o no está disponible en el servidor.
        BadRequest = 501,
        //Bad Gateway - Indica que el servidor, mientras actuaba como puerta de enlace o proxy, recibió una respuesta no válida del servidor ascendente (upstream server).
        Unauthorized = 502,
        //Service Unavailable - El servidor no está listo para manejar la solicitud.
        Info = 503
    }
}
