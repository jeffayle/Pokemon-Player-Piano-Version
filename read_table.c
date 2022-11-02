unsigned int table_index;
unsigned int current_count;
extern const unsigned short table[];

int read_key_table(void) {
    if (table[table_index*2+1] > current_count) {
        current_count++;
        return table[table_index*2];
    } else {
        current_count = 0;
        table_index++;
        return 0;
    }
}
