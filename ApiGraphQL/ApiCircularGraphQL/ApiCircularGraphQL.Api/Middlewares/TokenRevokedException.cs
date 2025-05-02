namespace ApiCircularGraphQL.Api.Middlewares
{
    public class TokenRevokedException : Exception
    {
        public TokenRevokedException(string message) : base(message) { }
    }
}
