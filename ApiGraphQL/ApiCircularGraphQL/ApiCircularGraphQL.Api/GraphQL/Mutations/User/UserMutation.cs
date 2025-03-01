namespace ApiCircularGraphQL.Api.GraphQL.Mutations.User
{
    [ExtendObjectType(typeof(Mutation))]
    public class UserMutation
    {
        public string Helooo => "Helo";
    }
}
