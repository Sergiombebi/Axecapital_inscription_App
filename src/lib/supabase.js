import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://kpmngaqwkmfnknriskar.supabase.co'
const supabaseKey = 'sb_publishable_iFP5B45DHKioHawBBm2S7A_5Bu01va7'

export const supabase = createClient(supabaseUrl, supabaseKey)