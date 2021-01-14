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
    reg [31:0] cnt;//32bit的变量, 用于计数
    reg [1:0] led_on_number;//2bit的变量,刚好可以对应4个led灯
    parameter CLOCK_FREQ = 50000000;//常量,50M时钟
    parameter COUNTER_MAX_CNT = CLOCK_FREQ/2-1;//常量,0.5s需要计数到多少
    
    always @(posedge clk, negedge rst_n) begin//每次clk上升沿或者rst_n下降沿时执行下面这段程序
        if(!rst_n) begin
            cnt <= 31'd0;
            led_on_number <= 2'd0;
        end
        else begin
            cnt <= cnt + 1'b1;//计数器+1
            if(cnt == COUNTER_MAX_CNT) begin// 计数 0.5s
                cnt <= 31'd0;
                led_on_number <= led_on_number + 1'b1;
            end
        end
    end
    
    always @(led_on_number) begin//当led_on_number发生改变时,执行下面程序
        case(led_on_number)
            0: led <= 4'b0001;
            1: led <= 4'b0010;
            2: led <= 4'b0100;
            3: led <= 4'b1000;
        endcase
    end
endmodule














