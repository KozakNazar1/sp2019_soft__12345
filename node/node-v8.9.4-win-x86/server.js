/**********************************************************************
* N.Kozak // Lviv'2019 // example server NodeJS(ILNW)-Asm for pkt4 SP *
*                         file: server.js                             *
*                                                              files: *
*                                                         asmfile.asm *
*                                                 wrapper_calclab3.cc *
*                                                           server.js *
*                                                                     *
*                                                   *extended version *
***********************************************************************/

function html_code_fmt__withGetSubmit(K, B, C, D, E, F, X_Assembly, X){

    var html_code_fmt__withGetSubmit = 
`<html>
<head>
<link rel="icon" href="data:;base64,=">
</head>
<body>

<form action="/setSettings" method="get">
<h1>Settings:</h1>
<p>Select mode:</p>  
  <input type="radio" name="mode" value="1"> mode 1<br>
  <input type="radio" name="mode" value="2"> mode 2<br>
  <input type="radio" name="mode" value="3"> mode 3<br> 
<p>Change used http-method:</p>
  <input type="radio" name="http_method" value="0" checked="checked"> GET<br>
  <input type="radio" name="http_method" value="1"> POST<br> 

  <input type="submit" value="Submit parameters and reload page" text="">
</form>
<h1>Compute board:</h1>
<button type="submit" form="calcData">Send values by GET and compute result</button>

<form id="calcData"  method="get" action="callCalc">

<h2>X = K + B2 - D2/C1 + E1*F2</h2>
<h2>--------------------------</h2>
<h2>K = ${K}</h2>
<h2>B = <input name="B" type="text" value="${B}"></h2>
<h2>C = <input name="C" type="text" value="${C}"></h2>
<h2>D = <input name="D" type="text" value="${D}"></h2>
<h2>E = <input name="E" type="text" value="${E}"></h2>
<h2>F = <input name="F" type="text" value="${F}"></h2>
<h2>-------</h2>
<h2>X(Assembly) = ${X_Assembly}</h2>
<h2>X(JavaScript by NodeJS) = ${X}</h2>
<h2>--------------------------</h2>
<input type="submit" value="Send values by GET and compute result">

</form>
</body>
</html>`;	

	return html_code_fmt__withGetSubmit;
}

function html_code_fmt__withPostSubmit(K, B, C, D, E, F, X_Assembly, X){

    var html_code_fmt__withPostSubmit = 
`<html>
<head>
<link rel="icon" href="data:;base64,=">
</head>
<body>

<form action="/setSettings" method="post">
<h1>Settings:</h1>
<p>Select mode:</p>  
  <input type="radio" name="mode" value="1"> mode 1<br>
  <input type="radio" name="mode" value="2"> mode 2<br>
  <input type="radio" name="mode" value="3"> mode 3<br> 
<p>Change used http-method:</p>
  <input type="radio" name="http_method" value="0"> GET<br>
  <input type="radio" name="http_method" value="1" checked="checked"> POST<br> 

  <input type="submit" value="Submit parameters and reload page" text="">
</form>
<h1>Compute board:</h1>
<button type="submit" form="calcData">Send values by POST and compute result</button>

<form id="calcData"  method="post" action="callCalc">

<h2>X = K + B2 - D2/C1 + E1*F2</h2>
<h2>--------------------------</h2>
<h2>K = ${K}</h2>
<h2>B = <input name="B" type="text" value="${B}"></h2>
<h2>C = <input name="C" type="text" value="${C}"></h2>
<h2>D = <input name="D" type="text" value="${D}"></h2>
<h2>E = <input name="E" type="text" value="${E}"></h2>
<h2>F = <input name="F" type="text" value="${F}"></h2>
<h2>-------</h2>
<h2>X(Assembly) = ${X_Assembly}</h2>
<h2>X(JavaScript by NodeJS) = ${X}</h2>
<h2>--------------------------</h2>
<input type="submit" value="Send values by POST and compute result">

</form>
</body>
</html>`;

	return html_code_fmt__withPostSubmit;
}

function http_response_fmt(html_code){
    let html_code_len = html_code.length;

    var http_response_fmt = 
`HTTP/1.1 200 OK
Date: Mon, 27 Jul 2009 12:28:53 GMT
Server: Apache/2.2.14 (Win32)
Last-Modified: Wed, 22 Jul 2009 19:15:56 GMT
Content-Length: ${html_code_len}
Status: 200
Content-Type: text/html
Connection: Closed

${html_code}`;

    return http_response_fmt;
}

function buildResponse(usePostSubmit, calc, B, C, D, E, F){
    const K = 0x00025630; // const value 

    var html_code;

    if(usePostSubmit){
        html_code = html_code_fmt__withPostSubmit(K, B, C, D, E, F, calc(B, C, D, E, F), K + B - D/C + E*F);
    }
	else{	
	    html_code = html_code_fmt__withGetSubmit(K, B, C, D, E, F, calc(B, C, D, E, F), K + B - D/C + E*F);
	}
	
	return http_response_fmt(html_code);
}

function handleClient(socket, calc){
	socket.on('data', function(data){        
        console.log('New client(2): ' + socket.remoteAddress + ':' + socket.remotePort + '.'); // console.log(`New client: ${socket.remoteAddress}:${socket.remotePort}`);	
			
		message = data.toString('ascii');
        //message = data.toString('utf-8')		
		
        http_method_key = "http_method="; 
        B_key = "B=";
        C_key = "C=";
        D_key = "D=";
        E_key = "E=";
        F_key = "F="; 
	
        if ((indexPOSTsubstring = message.indexOf("POST")) > -1 && (indexPOSTValues = message.indexOf("\r\n\r\n")) > -1){
            usePostSubmit = true;
        
            index = message.substring(indexPOSTValues).indexOf(http_method_key);
            if (index > -1) {		
                index += indexPOSTValues;		
                usePostSubmitValue: int = 0;
                if (usePostSubmit){
                    usePostSubmitValue = 1;
	    		}
                returnMatchObject = message.substring(index + http_method_key.length).match(/[-+]?(0[xX][\dA-Fa-f]+|0[0-7]*|\d+)/g)
                if(returnMatchObject){			
                    usePostSubmitValue = parseFloat(returnMatchObject[0]);		
	    		}				
                usePostSubmit = true;
                if (usePostSubmitValue == 0){
                    usePostSubmit = false;
	    		}
	    	}
        
            index = message.substring(indexPOSTValues).indexOf(B_key);	
            if (index > -1) {
                index += indexPOSTValues;					
                returnMatchObject = message.substring(index + B_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);		
                if(returnMatchObject){		
                    b2 = parseFloat(returnMatchObject[0]);   			
	    		}
	    	}				
            index = message.substring(indexPOSTValues).indexOf(C_key);
            if (index > -1) {
                index += indexPOSTValues;	            
                returnMatchObject = message.substring(index + C_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){		
                    c1 = parseFloat(returnMatchObject[0]);
	    		}
	    	}				
            index = message.substring(indexPOSTValues).indexOf(D_key);
            if (index > -1) {
                index += indexPOSTValues;	            
                returnMatchObject = message.substring(index + D_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){		
                    d2 = parseFloat(returnMatchObject[0]);
	    		}
	    	}				
            index = message.substring(indexPOSTValues).indexOf(E_key);
            if (index > -1) {
                index += indexPOSTValues;	            
                returnMatchObject = message.substring(index + E_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){	
                    e1 = parseFloat(returnMatchObject[0]);	
	    		}
	    	}				
            index = message.substring(indexPOSTValues).indexOf(F_key);
            if (index > -1) {
                index += indexPOSTValues;	            
                returnMatchObject = message.substring(index + F_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){		
                    f2 = parseFloat(returnMatchObject[0]);	
	    		}
	    	}
        }
	    else{
	    
            index = message.indexOf(http_method_key);
            if (index > -1) {
                usePostSubmitValue: int = 0;
                if (usePostSubmit) {
                    usePostSubmitValue = 1;
	    		}
                returnMatchObject = message.substring(index + http_method_key.length).match(/[-+]?(0[xX][\dA-Fa-f]+|0[0-7]*|\d+)/g);
                if(returnMatchObject){			
                    usePostSubmitValue = parseFloat(returnMatchObject[0]);	
	    		}				
                usePostSubmit = true;	
                if (usePostSubmitValue == 0) {				
                    usePostSubmit = false;  
	    		}				
	    	}
            else{
                index = message.indexOf(B_key);
                if (index > -1) {
                    usePostSubmit = false;
                    returnMatchObject = message.substring(index + B_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                    if(returnMatchObject){
                        b2 = parseFloat(returnMatchObject[0]);											   
	    	    	}
	    	    }
                index = message.indexOf(C_key);
                if (index > -1) {
                    usePostSubmit = false;
                    returnMatchObject = message.substring(index + C_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                    if(returnMatchObject){
                        c1 = parseFloat(returnMatchObject[0]);	
	    	    	}
                }				
                index = message.indexOf(D_key);
                if (index > -1) {
                    usePostSubmit = false
                    returnMatchObject = message.substring(index + D_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                    if(returnMatchObject){		
                        d2 = parseFloat(returnMatchObject[0]);			
	    	    	}
	    	    }
                index = message.indexOf(E_key);
                if (index > -1) {
                    usePostSubmit = false;
                    returnMatchObject = message.substring(index + E_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                    if(returnMatchObject){
                        e1 = parseFloat(returnMatchObject[0]);			
	    	    	}
	    	    }
                index = message.indexOf(F_key);
                if (index > -1) {
                    usePostSubmit = false;
                    returnMatchObject = message.substring(index + F_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                    if(returnMatchObject){			
                        f2 = parseFloat(returnMatchObject[0]);
	    	    	}
	    	    }
			}
	    }
  
        socket.write(buildResponse(usePostSubmit, calc, b2, c1, d2, e1, f2));
        //console.log(buildResponse(usePostSubmit, calc, b2, c1, d2, e1, f2));
        
        socket.end();
        socket.destroy();		
		
	});
    socket.on('close', function() {
        console.log('CLOSED: ' + socket.remoteAddress +' '+ socket.remotePort);
    });	
    socket.on('error', function() {
        console.log('Error: ' + socket.remoteAddress +' '+ socket.remotePort);
    });	
	
}

var net = require('net');
var textChunk = '';

console.log('12-123');

var HOST = '' // all available interfaces
var PORT = 80 // non-privileged port

var usePostSubmit = true; 
    
var b2 = 10.;    // float64 // defaault value          
var c1 = 20.;    // float32 // defaault value          
var d2 = 30.;    // float64 // defaault value         
var e1 = 40.;    // float32 // defaault value        
var f2 = 50.;    // float64 // defaault value 

const wrapper_calclab3 = require('bindings')('wrapper_calclab3');
const calc = wrapper_calclab3 === null ? null : wrapper_calclab3.calc;
if(wrapper_calclab3.calc === null){
    console.log("Module load error");
    return;
}

console.log("X = K + B2 - D2/C1 + E1*F2");
console.log("default: " + "K = 0x00025630; B2 = " + b2 + "; C1 = " + c1 + "; D2 = " + d2 + "; E1 = " + e1 + "; F2 = " + f2 + ";");
console.log("default: X(Assembly) = " + calc(b2, c1, d2, e1, f2));
console.log("default: X(JavaScript by NodeJS) = " + (0x00025630 + b2 - d2/c1 + e1*f2));

let ilnw_server = net.createServer(function(socket){
//handleClient(socket, calc); // 
handleClient__secondVersion(socket, calc);
});

ilnw_server.listen(PORT, HOST, () => {
    console.log('TCP Server is running on port ' + PORT + '.');
});

/* Second version *////////////////////////////////////////////////////////////////////////////

function readSocket(socket, calc, callBack) {
	socket.once('data', function(data){ // once
		callBack(socket, calc, data);
	});	
	socket.on('close', function() {    
	    console.log('CLOSED: ' + socket.remoteAddress +' '+ socket.remotePort);
	});	
	socket.on('error', function() {        
		console.log('Error: ' + socket.remoteAddress +' '+ socket.remotePort);
	});	
	
    //return;
}

function handleClient__secondVersion(socket, calc, data){
    console.log('New client: ' + socket.remoteAddress + ':' + socket.remotePort + '.'); // console.log(`New client: ${socket.remoteAddress}:${socket.remotePort}`);
    
    readSocket(socket, calc, handleClient__secondVersion);
    if(data === undefined){
        return;
    }  
  	
	message = data.toString('ascii');
    //message = data.toString('utf-8');
	
    http_method_key = "http_method="; 
    B_key = "B=";
    C_key = "C=";
    D_key = "D=";
    E_key = "E=";
    F_key = "F="; 
	
    if ((indexPOSTsubstring = message.indexOf("POST")) > -1 && (indexPOSTValues = message.indexOf("\r\n\r\n")) > -1){
        usePostSubmit = true;
    
        index = message.substring(indexPOSTValues).indexOf(http_method_key);
        if (index > -1) {		
            index += indexPOSTValues;		
            usePostSubmitValue: int = 0;
            if (usePostSubmit){
                usePostSubmitValue = 1;
			}
            returnMatchObject = message.substring(index + http_method_key.length).match(/[-+]?(0[xX][\dA-Fa-f]+|0[0-7]*|\d+)/g)
            if(returnMatchObject){			
                usePostSubmitValue = parseFloat(returnMatchObject[0]);		
			}				
            usePostSubmit = true;
            if (usePostSubmitValue == 0){
                usePostSubmit = false;
			}
		}
    
        index = message.substring(indexPOSTValues).indexOf(B_key);	
        if (index > -1) {
            index += indexPOSTValues;					
            returnMatchObject = message.substring(index + B_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);		
            if(returnMatchObject){		
                b2 = parseFloat(returnMatchObject[0]);   			
			}
		}				
        index = message.substring(indexPOSTValues).indexOf(C_key);
        if (index > -1) {
            index += indexPOSTValues;	            
            returnMatchObject = message.substring(index + C_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
            if(returnMatchObject){		
                c1 = parseFloat(returnMatchObject[0]);
			}
		}				
        index = message.substring(indexPOSTValues).indexOf(D_key);
        if (index > -1) {
            index += indexPOSTValues;	            
            returnMatchObject = message.substring(index + D_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
            if(returnMatchObject){		
                d2 = parseFloat(returnMatchObject[0]);
			}
		}				
        index = message.substring(indexPOSTValues).indexOf(E_key);
        if (index > -1) {
            index += indexPOSTValues;	            
            returnMatchObject = message.substring(index + E_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
            if(returnMatchObject){	
                e1 = parseFloat(returnMatchObject[0]);	
			}
		}				
        index = message.substring(indexPOSTValues).indexOf(F_key);
        if (index > -1) {
            index += indexPOSTValues;	            
            returnMatchObject = message.substring(index + F_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
            if(returnMatchObject){		
                f2 = parseFloat(returnMatchObject[0]);	
			}
		}
    }
	else{
	
        index = message.indexOf(http_method_key);
        if (index > -1) {
            usePostSubmitValue: int = 0;
            if (usePostSubmit) {
                usePostSubmitValue = 1;
			}
            returnMatchObject = message.substring(index + http_method_key.length).match(/[-+]?(0[xX][\dA-Fa-f]+|0[0-7]*|\d+)/g);
            if(returnMatchObject){			                    
				usePostSubmitValue = parseFloat(returnMatchObject[0]);	
	    	}				
            usePostSubmit = true;	
            if (usePostSubmitValue == 0) {				
                usePostSubmit = false;  
	    	}				
	    }
        else{
            index = message.indexOf(B_key);
            if (index > -1) {
                usePostSubmit = false;
                returnMatchObject = message.substring(index + B_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){
                    b2 = parseFloat(returnMatchObject[0]);											   
	        	}
	        }
            index = message.indexOf(C_key);
            if (index > -1) {
                usePostSubmit = false;
                returnMatchObject = message.substring(index + C_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){
                    c1 = parseFloat(returnMatchObject[0]);	
	        	}
            }				
            index = message.indexOf(D_key);
            if (index > -1) {
                usePostSubmit = false
                returnMatchObject = message.substring(index + D_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){		
                    d2 = parseFloat(returnMatchObject[0]);			
	        	}
	        }
            index = message.indexOf(E_key);
            if (index > -1) {
                usePostSubmit = false;
                returnMatchObject = message.substring(index + E_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){
                    e1 = parseFloat(returnMatchObject[0]);			
	        	}
	        }
            index = message.indexOf(F_key);
            if (index > -1) {
                usePostSubmit = false;
                returnMatchObject = message.substring(index + F_key.length).match(/[-+]?(\d+([.,]\d*)?|[.,]\d+)([eE][-+]?\d+)?/g);
                if(returnMatchObject){			
                    f2 = parseFloat(returnMatchObject[0]);
	        	}
	        }
		}
	}
  
    socket.write(buildResponse(usePostSubmit, calc, b2, c1, d2, e1, f2));
    //console.log(buildResponse(usePostSubmit, calc, b2, c1, d2, e1, f2));
    
    socket.end();
    socket.destroy();
}