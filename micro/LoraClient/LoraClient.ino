#include <SoftwareSerial.h>
#define rxs 10 // arduino soft rx
#define txs 11 // arduino soft tx#define led 13
#define led 13 // arduino soft tx#define led 13

const int device_id = 14;
 
const char cmd_connect[] = "connect";
const char cmd_config[] = "config";
const char cmd_readings[] = "readings";
const char cmd_ack[] = "ack";
const char key[] = "secret";

const int tx_connect = 15;
volatile int tx_period = 0;
volatile int tx_slot = 0;
volatile int rx_time = 0;
volatile int sync = 0;

volatile int actuator1 = 0;
volatile int actuator2 = 0;

volatile bool flag_configured = false;

volatile int edges[2];

const int buffer_size = 40;
volatile char in_c;
volatile int in_i = 0;
char out_buffer[buffer_size];
char in_buffer[buffer_size];
char keyid[10];
SoftwareSerial SSerial(rxs,txs);

void setup(){
	pinMode(led, OUTPUT);
  	SSerial.begin(9600);
  	Serial.begin(115200);
}

void send_command(const char *message){
	SSerial.println(message);
	Serial.println(message);
}

void connect_frame(int id){
	sprintf(out_buffer, "%s%d%s", key, id, cmd_connect);
}

void data_frame(int id){
	sprintf(out_buffer, "%s%d%s,%d,%d,%d",
		key, id, cmd_readings,
		5, 10, 15
	);
}

int strtoi(const char *text, const int start, const int end){
	// xx21xx
	int result = 0;
	int i = 0;
	while (i <= (end-start)){
		result = 10*result + text[start+i] - 48;
		i++;
	}
	// 21
	return result;
}

int find_comma(const char *text, const int start){
	char * pch;
	pch = (char*) memchr (&text[start], ',', strlen(text));
	if (pch != NULL) return min(pch - text, strlen(text)-1);
}

void find_edges(const char *text, int order){
	int start = 0;
	int end = 0;
	int i = 0;
	while ((find_comma(text, start) != -1) && (i<=order)){
		start = end;
		end = find_comma(text, start+1);
		i++;
	}
	edges[0] = start == 0 ? start : start+1;
	edges[1] = end - 1;
}

void proccess_config(){
	//config,20,5,5,15
	int start = 0;
	int end = 0;
	Serial.println("ProcessingCONFIG");
	Serial.println(in_buffer);
	find_edges(in_buffer,1); tx_period = strtoi(in_buffer,edges[0],edges[1]);
	find_edges(in_buffer,2); tx_slot = strtoi(in_buffer,edges[0],edges[1]);
	find_edges(in_buffer,3); rx_time = strtoi(in_buffer,edges[0],edges[1]);
	find_edges(in_buffer,4); sync = strtoi(in_buffer,edges[0],edges[1]);
	flag_configured = true;
}

void proccess_ack(){
	Serial.println("ProcessingACK");
}

void proccess_commands(){
	sprintf(keyid, "%s%d", key, device_id);
	if(memcmp(keyid, in_buffer, strlen(keyid)) == 0) {
		//secretidxxxxxxxxxxx
		memcpy(&in_buffer, &in_buffer[strlen(keyid)] ,strlen(in_buffer)-strlen(keyid));
		//xxxxxxxxxxxxxxxxxxx
		in_buffer[strlen(in_buffer)-strlen(keyid)] = 0;
		if(memcmp(cmd_config, in_buffer, strlen(cmd_config))==0) proccess_config();
		if(memcmp(cmd_ack, in_buffer, strlen(cmd_ack))==0) proccess_ack();
	}
}

void read_commands(){
	while (SSerial.available())
    {
	    in_c = SSerial.read();
	    in_buffer[in_i] = in_c;
	    in_i += 1;
	    if ((in_c == '\n') || (in_c == '\r')){
	    	in_buffer[in_i] = 0;
	    	in_i = 0;
	    	Serial.print(in_buffer);
	    	proccess_commands();
	    }
	}
}

void loop(){
	//Serial.println("port0");
	//SSerial.println("port1");
	//SSerial.println(t);
	//send_command(cmd_connect);
	connect_frame(device_id);
	send_command(out_buffer);
	//data_frame(device_id);
	//send_command(out_buffer);
	read_commands();
	digitalWrite(led, HIGH);delay(110);digitalWrite(led, LOW);	delay(3000);	
}

