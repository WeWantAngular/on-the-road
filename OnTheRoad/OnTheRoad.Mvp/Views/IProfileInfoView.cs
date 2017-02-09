﻿using System;
using OnTheRoad.Mvp.EventArgsClasses;
using OnTheRoad.Mvp.Models;
using WebFormsMvp;

namespace OnTheRoad.Mvp.Profile.Contracts
{
    public interface IProfileInfoView : IView<ProfileInfoModel>
    { 
        event EventHandler<ProfileInfoEventArgs> GetProfileInfo;

        event EventHandler<ProfileInfoEventArgs> UpdateProfileInfo;

        event EventHandler<ProfileInfoEventArgs> CheckIfUserExists;
    }
}
