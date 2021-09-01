<%@ language="RPGLE"%>
<%
ctl-opt main(sayHello); 
dcl-proc sayHello;
	
    dcl-s  message      varchar(256);
    
    // Get the data from the URL
    message = qryStr('message');

    // Send the response back 
    %>Hello world. <%= message %>, time is <%= %char(%timestamp())%><%

end-proc;