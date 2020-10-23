#ifndef UART_H_
#define UART_H_

void initUART();
char receiveChar();
void sendChar(char d);
void sendString(char* d);

#endif /* UART_H_ */