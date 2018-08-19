<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UsedPartsDepot._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .caption {
            position: absolute;
            top: 45%;
            left: 0;
            width: 100%;
            pointer-events: none;
        }

        .caption-text {
            color: #ffffff;
            font-size: 30px;
        }
    </style>

    <div class="row">
        <div class="col-md-12 text-center">
            <h2>Getting started</h2>
            <p>
                Select the year, make and model of your vehicle then select from multiple parts types to find your next used part easily!
            </p>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanelSelectVehicle" runat="server">
        <ContentTemplate>

            <div class="row" style="padding-bottom: 20px;">
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlYear" class="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlMake" class="form-control" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="ddlMake_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlModel" class="form-control" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="ddlModel_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlTrim" class="form-control" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="ddlTrim_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Panel ID="pnlPartSelectMenu" runat="server">
        <asp:MultiView ID="mvPartsSelection" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwMainParts" runat="server">
                <div class="row thumbnail" style="padding-bottom: 20px; padding-top: 20px;">
                    <div class="col-md-12">
                        <div class="row text-center" style="padding-bottom: 30px">
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnEngine" runat="server" ImageUrl="~/Photos/Engine.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Engine</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnBrakes" runat="server" ImageUrl="~/Photos/Brakes.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Brakes</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnBody" runat="server" ImageUrl="~/Photos/body.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Body</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnDriveTrain" runat="server" ImageUrl="~/Photos/Drivetrain.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Drivetrain</p>
                                </div>
                            </div>
                        </div>
                        <div class="row text-center">
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnExhaust" runat="server" ImageUrl="~/Photos/Exhaust.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Ehaust</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnGearBox" runat="server" ImageUrl="~/Photos/Gearbox.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Gearbox</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnHeatingCooling" runat="server" ImageUrl="~/Photos/HeatingCooling.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Heating/Cooling</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:ImageButton ID="btnTires" runat="server" ImageUrl="~/Photos/Tires.jpg" class="img-thumbnail" OnClick="btnMainCategory_Click" />
                                <div class="caption">
                                    <p class="caption-text">Tires</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:View>
            <asp:View ID="vmSubCategories" runat="server">
                <div class="row thumbnail">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3" style="padding-top: 12px;">
                                <asp:Button ID="btnBackCategory" runat="server" Text="Back" OnClick="btnBackCategory_Click" class=" form-control btn btn-danger" />
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 20px; padding-top: 20px;">
                            <asp:UpdatePanel ID="UpdatePanelSubCategories" runat="server">
                                <ContentTemplate>
                                    <div class="col-md-12">
                                        <asp:Panel ID="pnlSubCategories" runat="server">
                                        </asp:Panel>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>

            </asp:View>
        </asp:MultiView>
    </asp:Panel>
 <script lang="javascript" type="text/javascript">
        function DoPostBack(obj) {
            __doPostBack(obj.id, 'OtherInformation');
        } 
    </script>


</asp:Content>
