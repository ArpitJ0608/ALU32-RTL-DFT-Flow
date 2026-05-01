import re



with open("alu_scanned.v.chain-intermediate.v", "r") as f:

    lines = f.readlines()



out = []

i = 0

replaced = 0



while i < len(lines):

    if lines[i].strip() == "dfcrq1":

        block_start = i

        block = []

        while i < len(lines):

            block.append(lines[i])

            if ");" in lines[i]:

                break

            i += 1

        block_text = "".join(block)



        if "(shift)?" in block_text:

            inst  = re.search(r'dfcrq1\s+(\w+)', block_text).group(1)

            cdn   = re.search(r'\.CDN\(([^)]+)\)', block_text).group(1).strip()

            cp    = re.search(r'\.CP\(([^)]+)\)', block_text).group(1).strip()

            d_mux = re.search(r'\.D\(\(shift\)\?\s*([^:]+?)\s*:\s*([^)]+?)\s*\)', block_text)

            sd    = d_mux.group(1).strip()

            d     = d_mux.group(2).strip()

            q     = re.search(r'\.Q\(([^)]+)\)', block_text).group(1).strip()



            new_block = (
                f"  sdnrq1\n"
                f"  {inst}\n"
                f"  (\n"
                f"    .CDN({cdn}),\n"
                f"    .CP({cp}),\n"
                f"    .D({d}),\n"
                f"    .SD({sd}),\n"
                f"    .SC(shift),\n"
                f"    .Q({q})\n"
                f"  );\n"
            )

            out.append(new_block)

            replaced += 1
        else:

            out.extend(block)

    else:

        out.append(lines[i])

    i += 1
with open("alu_scanned_final.v", "w") as f:

    f.writelines(out)
print(f"Replaced {replaced} dfcrq1 with sdnrq1")
