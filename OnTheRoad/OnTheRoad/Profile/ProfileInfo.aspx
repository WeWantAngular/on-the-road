﻿<%@ Page Language="C#" MasterPageFile="~/Profile/UserProfile.master" AutoEventWireup="true" CodeBehind="ProfileInfo.aspx.cs" Inherits="OnTheRoad.Profile.ProfileInfo" %>

<%@ Register TagPrefix="uc" TagName="CitiesDropDown" Src="~/CustomControllers/CitiesDropDown.ascx" %>
<%@ Register TagPrefix="uc" TagName="ImageUploader" Src="~/CustomControllers/ImageUploader.ascx" %>

<asp:Content ContentPlaceHolderID="ProfileContent" ID="ProfileInfo" runat="server">
    <div class="row  back-container box-shadow">
        <div class="col-md-12">
            <asp:Label runat="server" ID="LabelErrors" />
            <asp:UpdatePanel runat="server" ID="UpdatePanelFollowingButtons" EnableViewState="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Button Text="ПОСЛЕДВАЙ" runat="server" Visible="false"
                        ID="ButtonFollow"
                        OnClick="ButtonFollow_Click"
                        CssClass="btn btn-success btn-follow" />
                    <asp:Button Text="ПРЕМАХНИ ОТ СЛЕДВАНИ" runat="server" Visible="false"
                        ID="ButtonUnfollow"
                        OnClick="ButtonUnfollow_Click"
                        CssClass="btn btn-warning btn-follow" />
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:FormView ID="FormViewProfileInfo" runat="server"
                ItemType="OnTheRoad.Mvp.Models.ProfileInfoModel">
                <ItemTemplate>
                    <h2 class="page-headers username-header text-center">
                        <asp:Literal Text='<%# Item.Username %>' runat="server" />
                    </h2>
                    <br />
                    <div class="row">
                        <div class="col-md-4">
                            <asp:Image ID="ImageUser" runat="server"
                                ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String(Item.Image) %>'
                                CssClass="img-responsive"></asp:Image>
                        </div>
                        <div class="col-md-8">
                            <div class="form-group">
                                <i class="fa fa-user-circle font-awesome" aria-hidden="true"></i>
                                <asp:Literal Text='<%# Item.FirstName + " " + Item.LastName %>' runat="server" />
                            </div>
                            <div class="form-group">
                                <i class="fa fa-envelope-o font-awesome" aria-hidden="true"></i>
                                <asp:Literal Text='<%# Item.Email %>' runat="server" />
                            </div>
                            <div class="form-group">
                                <i class="fa fa-map-marker font-awesome" aria-hidden="true"></i>
                                <asp:Literal ID="LiteralCityName" Text='<%# Item.City %>' runat="server" />
                            </div>
                            <div class="form-group">
                                <i class="fa fa-mobile font-awesome" aria-hidden="true"></i>
                                <asp:Literal Text='<%# Item.PhoneNumber %>' runat="server" />
                            </div>
                            <div class="form-group">
                                <i class="fa fa-id-card-o font-awesome" aria-hidden="true"></i>
                                <asp:Literal Text='<%# Item.Info %>' runat="server" />
                            </div>
                        </div>
                    </div>

                </ItemTemplate>
                <EditItemTemplate>
                    <h2 class="page-headers">Промяна на профил</h2>
                    <br />
                    <div class="row">
                        <div class="col-md-4">
                            <asp:Image ID="ImageUser" runat="server" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String(this.Model.Image) %>' CssClass="img-responsive"></asp:Image>
                            <uc:ImageUploader ID="ImageUploader" runat="server"
                                OnImageUpload="ImageUploader_ImageUpload"
                                OnImageError="ImageUploader_Error" />
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group ">
                                        <label class="input-labels">първо име</label>
                                        <asp:TextBox ID="FirstName" Text='<%#: Item.FirstName%>' runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label class="input-labels">град</label>
                                        <uc:CitiesDropDown ID="City" SelectCityName="<%# Item.City %>" runat="server" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="input-labels">фамилно име</label>
                                        <asp:TextBox ID="LastName" Text='<%#: Item.LastName %>' runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label class="input-labels">тел. номер</label>
                                        <asp:TextBox ID="PhoneNumber" Text='<%#: Item.PhoneNumber%>' runat="server" CssClass="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 form-group">
                                    <label class="input-labels">кратка информация</label>
                                    <asp:TextBox ID="Info" TextMode="MultiLine" Rows="5" Text='<%#: Item.Info %>' runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <asp:LinkButton ID="ButtonSave" runat="server"
                        OnClick="ButtonSave_Click"
                        Text="ЗАПАЗИ"
                        CssClass="btn btn-success">
                    </asp:LinkButton>
                </EditItemTemplate>
            </asp:FormView>
            <asp:LinkButton ID="ButtonEdit" runat="server" OnClick="ButtonEdit_Click" Text="ПРОМЕНИ" CssClass="btn btn-warning"></asp:LinkButton>
        </div>
    </div>

    <br />

    <div class="row back-container ">
        <asp:Panel runat="server" ID="PanelFavouriteUsers" CssClass="col-md-12 fav-users">
            <h3 class="page-headers fav-users-header">Любими пътешественици</h3>
            <asp:Repeater runat="server" ID="RepeaterFavouriteUsers" OnItemDataBound="RepeaterFavouriteUsers_ItemDataBound"
                ItemType="OnTheRoad.Domain.Models.IUser">
                <ItemTemplate>
                    <div class="fav-user-wrapper">
                        <asp:Image runat="server" CssClass="favUserImage img-circle"
                            ImageUrl='<%#: "data:image/jpeg;base64," + Convert.ToBase64String(Item.Image) %>' />
                        <asp:Panel runat="server" ID="PanelUnfollow" class="btn-group">
                            <button type="button"
                                class="btn-dropdown btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <asp:Button
                                        runat="server"
                                        Text="премахни"
                                        CssClass="btn-unfollow"
                                        CommandArgument="<%#: Item.Username %>"
                                        OnClick="DropdownUnfollow_Click" />
                                </li>
                            </ul>
                        </asp:Panel>
                        <asp:HyperLink runat="server"
                            ID="LinkButtonFollowing"
                            Text="<%#: Item.Username %>"
                            NavigateUrl='<%#: "~/Profile/ProfileInfo.aspx?name=" + Item.Username %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>
    </div>

</asp:Content>
