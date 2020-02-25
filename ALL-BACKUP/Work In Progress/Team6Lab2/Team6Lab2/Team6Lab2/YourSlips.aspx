<%@ Page Title="YourSlips" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="YourSlips.aspx.cs" Inherits="Team6Lab2.YourSlips" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Your slip reservation history</h2>
    <h3>List below of all your slips</h3>
    <p>Current Customer</p>
    <p>
        <asp:Label ID="lblCustomerID" runat="server"></asp:Label>
    </p>
    <p>Select your slip ID for more information</p>
    <p>
        <asp:DropDownList ID="ddlCustomerSlips" runat="server" AutoPostBack="True" DataSourceID="SlipIdDataSource" DataTextField="SlipID" DataValueField="SlipID" ForeColor="Black">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SlipIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarinaConnectionString %>" SelectCommand="SELECT [SlipID] FROM [Lease] WHERE ([CustomerID] = @CustomerID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCustomerID" Name="CustomerID" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:FormView ID="frmviewSlipInfo" runat="server" DataKeyNames="id" DataSourceID="SqlDataSource4" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Both" Width="228px">
            <EditItemTemplate>
                id:
                <asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' />
                <br />
                width:
                <asp:TextBox ID="widthTextBox" runat="server" Text='<%# Bind("width") %>' />
                <br />
                length:
                <asp:TextBox ID="lengthTextBox" runat="server" Text='<%# Bind("length") %>' />
                <br />
                Name:
                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                <br />
                ElectricalService:
                <asp:CheckBox ID="ElectricalServiceCheckBox" runat="server" Checked='<%# Bind("ElectricalService") %>' />
                <br />
                WaterService:
                <asp:CheckBox ID="WaterServiceCheckBox" runat="server" Checked='<%# Bind("WaterService") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <EditRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <InsertItemTemplate>
                width:
                <asp:TextBox ID="widthTextBox" runat="server" Text='<%# Bind("width") %>' />
                <br />
                length:
                <asp:TextBox ID="lengthTextBox" runat="server" Text='<%# Bind("length") %>' />
                <br />
                Name:
                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                <br />
                ElectricalService:
                <asp:CheckBox ID="ElectricalServiceCheckBox" runat="server" Checked='<%# Bind("ElectricalService") %>' />
                <br />
                WaterService:
                <asp:CheckBox ID="WaterServiceCheckBox" runat="server" Checked='<%# Bind("WaterService") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                id:
                <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                <br />
                width:
                <asp:Label ID="widthLabel" runat="server" Text='<%# Bind("width") %>' />
                <br />
                length:
                <asp:Label ID="lengthLabel" runat="server" Text='<%# Bind("length") %>' />
                <br />

                Name:
                <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                <br />
                ElectricalService:
                <asp:CheckBox ID="ElectricalServiceCheckBox" runat="server" Checked='<%# Bind("ElectricalService") %>' Enabled="false" />
                <br />
                WaterService:
                <asp:CheckBox ID="WaterServiceCheckBox" runat="server" Checked='<%# Bind("WaterService") %>' Enabled="false" />
                <br />

            </ItemTemplate>
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
        </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MarinaConnectionString %>" SelectCommand="SELECT slip.id, slip.width, slip.length, dock.Name, dock.ElectricalService, dock.WaterService
FROM slip join lease
ON slip.ID = lease.SlipID
JOIN dock
ON slip.DockID = dock.ID
WHERE slip.ID = @SlipID">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCustomerSlips" Name="SlipID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>&nbsp;</p>
</asp:Content>