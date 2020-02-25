using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Team6Lab2.Startup))]
namespace Team6Lab2
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
