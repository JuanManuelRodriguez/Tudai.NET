﻿<%@ Page Language="C#"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>How to Use UpdatePanel in ASP.NET</title>
    <script language="C#" runat="server">
        /*Ajax updatepanel will help us to avoid full postback of the page i.e., avoid refresh of the whole page content with postback and stop 
         * flickering of the page which is associated with a postback and allows only partial postbacks. By using Ajax updatepanel we can refresh only 
         * required part of page instead of refreshing whole page.*/
        public void Page_Load(Object sender, EventArgs e)
        {
            //Print the time when the page loaded initially
            if (!IsPostBack)
            {
                //set the default values
                Response.Write("The Page Loaded at: " + DateTime.Now.ToLongTimeString());                
                //set the time for both the labels initially
                try
                {
                    lblPanel1.Text = DateTime.Now.ToLongTimeString();
                    lblPanel2.Text = DateTime.Now.ToLongTimeString();
                }
                catch (Exception error)
                {
                    Response.Write("Error : " + error.Message);
                }
            }
        }
        //on click of the button(update panel 1) update both the panels
        public void btnPanel1_Click(Object sender, EventArgs e)
        {
            lblPanel1.Text = DateTime.Now.ToLongTimeString();
            lblPanel2.Text = DateTime.Now.ToLongTimeString();
        }
        //on click of the button(update both panels) update both the panels
        public void btnPanelBoth_Click(Object sender, EventArgs e)
        {
            lblPanel1.Text = DateTime.Now.ToLongTimeString();
            lblPanel2.Text = DateTime.Now.ToLongTimeString();
        }
    </script>
    <style type="text/css">
    .button
    {
      border-radius:4px 4px 4px 4px;
      height:30px;
      padding:5px;
      font-size:14px;
      background-color:#6ca21e;
      color:#FFFFFF;
      width:250px;
    }
    body
    {
      background-color:#32373a;
      color:#FFFFFF;
    }
    fieldset
    {
        width:120px;
    }
    .UserControlDiv
    {
        width:250px;margin:10px;padding:10px;border:1px solid Gray;background-color:#fdd136;color:Black;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <h1>
        How to Use UpdatePanel in ASP.NET
    </h1>
    <div>
        <asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server" />
        <!-- 
        This is the first update panel. Update Panel has a ContentTemplate which contains the elements which you want to participate in partial postback, instead
        of full postback. Here we have a label lblPanel1 which contains the value that is updated on each partial postback. The postbacks triggered from within this
        update panel, causes a partial postback and not the full postback. UpdatePanel has a property called UpdateMode which has value "Conditional" and "Always"(default)
        if it is "Always" any postback(normal or partial) will cause this panel controls to be updated. If it is "Conditional" the controls within it are either updated
        if any partial postback happens from within that panel or if set as trigger from any other panel(as seen in panel2);

        So here if we click on btnPanel1/btnPanelBoth for this panel the lblPanel1 is updated always
        But for UpdatePanel2 there is a AsyncPostBackTrigger applied which says that only update the panel2 when the control "btnPanelBoth" specified in ControlID
        and event name "Click" is executed. so in this case when the btnPanelBoth in Panel1 is clicked lblPanel2 from UpdatePanel2 is also updated, but not from 
        btnPanel1
        -->
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <fieldset title="Panel1">
                    <legend>Panel 1</legend>
                    <asp:Label CssClass="UserControlDiv" ID="lblPanel1" runat="server" />
                    <asp:Button CssClass="button" ID="btnPanel1" OnClick="btnPanel1_Click" Text="Update this Panel(Panel 1)" runat="server" />
                    <asp:Button CssClass="button" ID="btnPanelBoth" OnClick="btnPanelBoth_Click" Text="Update both Panels(Panel 1 & 2)" runat="server" />
                </fieldset>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br /><br />
        <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <fieldset title="Panel2">
                <legend>Panel 2</legend>
                    <asp:Label CssClass="UserControlDiv" ID="lblPanel2" runat="server" />
                </fieldset>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnPanelBoth" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
