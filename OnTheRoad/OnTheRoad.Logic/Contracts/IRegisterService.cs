﻿namespace OnTheRoad.Logic.Contracts
{
   public interface IRegisterService
    {
        void CreateUser(string email, string password, string firstName, string lastName);
    }
}
