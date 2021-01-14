`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/07 21:45:55
// Design Name: 
// Module Name: led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led(
    output reg[3:0] led,//1==on; 0=o=ff
    input clk,//50M
    input rst_n//reset pin
    );
    reg [31:0] cnt;//32bit�ı���, ���ڼ���
    reg [1:0] led_on_number;//2bit�ı���,�պÿ��Զ�Ӧ4��led��
    parameter CLOCK_FREQ = 50000000;//����,50Mʱ��
    parameter COUNTER_MAX_CNT = CLOCK_FREQ/2-1;//����,0.5s��Ҫ����������
    
    always @(posedge clk, negedge rst_n) begin//ÿ��clk�����ػ���rst_n�½���ʱִ��������γ���
        if(!rst_n) begin
            cnt <= 31'd0;
            led_on_number <= 2'd0;
        end
        else begin
            cnt <= cnt + 1'b1;//������+1
            if(cnt == COUNTER_MAX_CNT) begin// ���� 0.5s
                cnt <= 31'd0;
                led_on_number <= led_on_number + 1'b1;
            end
        end
    end
    
    always @(led_on_number) begin//��led_on_number�����ı�ʱ,ִ���������
        case(led_on_number)
            0: led <= 4'b0001;
            1: led <= 4'b0010;
            2: led <= 4'b0100;
            3: led <= 4'b1000;
        endcase
    end
endmodule














