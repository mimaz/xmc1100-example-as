##
 # Mieszko Mazurek
 # Jul 2018
 ##

ASFLAGS=-mthumb -mcpu=cortex-m0
LDFLAGS=-L/usr/arm-none-eabi/lib/thumb/v6-m -lc -Tlink.ld -nostartfiles --whole-archive --no-gc-sections

AS=arm-none-eabi-as
LD=arm-none-eabi-ld
SIZE=arm-none-eabi-size


SRC=startup.s main.s
BUILD_DIR=build
ELF=program.elf
OBJ=${SRC:%=${BUILD_DIR}/%.o}

all: ${ELF}

clean:
	rm -rf ${BUILD_DIR} ${ELF}

flash: ${ELF}
	openocd -f board/xmc-2go.cfg -c "init" -c "halt" -c "program $< verify reset exit" -c "reset run"

size: ${ELF}
	${SIZE} $<

${ELF}: ${OBJ}
	${LD} ${LDFLAGS} -o $@ $^

${BUILD_DIR}/%.s.o: %.s
	@mkdir -p ${dir $@}
	${AS} ${ASFLAGS} -o $@ -c $<
