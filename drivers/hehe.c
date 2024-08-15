#include <linux/init.h>
#include <linux/module.h>

MODULE_LICENSE("Vilex");

static int hehe_init(void) {
    printk("Hehehehehehehehhehe\n");
    return 0;
}

static void hehe_exit(void) {
    printk("Nowayyyyyyyyyyyyyyyy\n");
}

module_init(hehe_init);
module_exit(hehe_exit);