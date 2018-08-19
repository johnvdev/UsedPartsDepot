using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(UsedPartsDepot.Startup))]
namespace UsedPartsDepot
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
