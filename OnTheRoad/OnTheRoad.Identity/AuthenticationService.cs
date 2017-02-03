﻿using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Linq;

using OnTheRoad.Identity.Interfaces;
using System.Web;

namespace OnTheRoad.Identity
{
    public class AuthenticationService : IRegisterService, ILoginService
    {
        public AuthenticationService(ApplicationUserManager appUserManager, ApplicationSignInManager appSignInManager)
        {
            this.AppUserManager = appUserManager;
            this.AppSignInManager = appSignInManager;
        }

        private ApplicationUserManager AppUserManager { get; set; }
        private ApplicationSignInManager AppSignInManager { get; set; }

        public void CreateUser(string email, string password)
        {
            var user = new ApplicationUser() { UserName = email, Email = email, City = "Varna", Country = "Bulgaria" };
            IdentityResult result = this.AppUserManager.Create(user, password);

            if (result.Succeeded)
            {
                // Add initial User Role
                //var currentUser = this.AppUserManager.FindByName(email);
                //this.AppUserManager.AddToRole(currentUser.Id, "Admin");
                this.AppSignInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                var userId = this.AppUserManager.FindByName(email).Id;
                HttpCookie cookie = new HttpCookie("UserInfo");
                cookie.Values.Add("UserId", userId);
            }
            else
            {
                // TODO: Create custom exception?
                throw new ArgumentException(result.Errors.FirstOrDefault());
            }
        }

        public string LoginUser(string email, string password, bool rememberMe)
        {
            SignInStatus result = this.AppSignInManager.PasswordSignIn(email, password, rememberMe, shouldLockout: false);
            return result.ToString();
        }
    }
}