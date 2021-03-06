﻿using System;
using System.Linq;
using Ninject;
using Ninject.Activation;
using Ninject.Extensions.Factory;
using Ninject.Modules;
using WebFormsMvp;
using WebFormsMvp.Binder;
using OnTheRoad.Mvp.Factories;

namespace OnTheRoad.App_Start.BindingModules
{
    public class MVPBindingsModule : NinjectModule
    {
        public override void Load()
        {
            this.Bind<IPresenterFactory>()
                .To<CustomWebFormsMvpPresenterFactory>()
                .InSingletonScope();

            this.Bind<ICustomPresenterFactory>()
                .ToFactory()
                .InSingletonScope();

            this.Bind<IPresenter>()
                .ToMethod(this.PresenterFactoryMethod)
                .Named("Presenter");
        }

        private IPresenter PresenterFactoryMethod(IContext ctx)
        {
            var parameters = ctx.Parameters.ToList();

            var requestedType = (Type)parameters[0].GetValue(ctx, null);
            if (requestedType == null)
            {
                throw new ArgumentNullException("Invalid requested presenter type.");
            }

            var viewType = (Type)parameters[1].GetValue(ctx, null);
            if (viewType == null)
            {
                throw new ArgumentNullException("Invalid requested view type.");
            }

            var viewTypeInterface = viewType.GetInterfaces().FirstOrDefault(x => x.Name.Contains("View") && !x.Name.Contains("IView"));
            if (viewTypeInterface == null)
            {
                throw new ArgumentNullException("Invalid requested view type.");
            }

            var viewInstance = (IView)parameters[2].GetValue(ctx, null);
            if (viewInstance == null)
            {
                viewInstance = (IView)ctx.Kernel.Get(viewType);
            }

            // Unknown possible parameters for each separate IPresenter
            // Binding the view so Ninject can resolve each of them separately.
            var bindingExists = this.Kernel.GetBindings(viewTypeInterface).Any();
            if (bindingExists)
            {
                this.Rebind(viewTypeInterface).ToMethod(context => viewInstance);
            }
            else
            {
                this.Bind(viewTypeInterface).ToMethod(context => viewInstance);
            }

            return (IPresenter)ctx.Kernel.Get(requestedType);

            // Alternative binding.
            // http://webformsmvpcontrib.codeplex.com/SourceControl/latest#WebFormsMvp.Contrib/WebFormsMvp.Contrib.Ninject/MvpPresenterKernel.cs
            // Depends on correct constructor parameter name.
            //var viewInstanceParameter = new ConstructorArgument("view", viewInstance);

            //return (IPresenter)ctx.Kernel.Get(requestedType, viewInstanceParameter);
        }
    }
}