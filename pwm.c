#include <stdint.h>

#define REG32(ADD) (*(volatile uint32_t *)(ADD))

#define RCC_BASE		0x40023800

#define GPIOA_EN		REG32(RCC_BASE + 0x30)
#define TIM3_EN  		REG32(RCC_BASE + 0x40)

#define GPIOA_BASE 		0x40020000
#define GPIOA_TYPE		REG32(GPIOA_BASE + 0x00)
#define GPIOA_AF2		REG32(GPIOA_BASE + 0x20)

#define TIM3_BASE		0x40000400
#define TIM3_CR			REG32(TIM3_BASE + 0x00)
#define TIM3_PSC		REG32(TIM3_BASE + 0x28)
#define TIM3_FREQ		REG32(TIM3_BASE + 0x2C)
#define TIM3_DUTY		REG32(TIM3_BASE + 0x30)
#define TIM3_PWM		REG32(TIM3_BASE + 0x34)
#define TIM3_PWM1CC1 		REG32(TIM3_BASE + 0x18)
#define TIM3_UG			REG32(TIM3_BASE + 0x14)
#define TIM3_CCER		REG32(TIM3_BASE + 0x20)
#define TIM3_UI			REG32(TIM3_BASE + 0x0C)

void init_clk(void){
	GPIOA_EN		|= (1 << 0);
	TIM3_EN 		|= (1 << 1);
}

void init_gpio(void){
	GPIOA_TYPE		|= (1 << 13);
	GPIOA_AF2 		|= (1 << 25);
}

void init_tim3(void){
	TIM3_PSC		= (uint32_t)0x00;
	TIM3_FREQ		= (uint32_t)0xd2;
	TIM3_PWM1CC1	 	= (uint32_t)0x68;
	TIM3_UG			= (uint32_t)0x01;
	TIM3_CCER		= (uint32_t)0x01;
	TIM3_UI			= (uint32_t)0x01;
	TIM3_PWM 		= (uint32_t)0x01; 
	TIM3_CR			= (uint32_t)0x01;
}

void main(void){
	init_clk();
	init_gpio();
	init_tim3();

	while(1){

	}
}

void _exit(int code)
{
    while(1);
}
