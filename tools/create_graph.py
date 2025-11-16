import sys
import matplotlib.pyplot as plt

PRE_RECROD_STR = "Technology:"
DATA_LINE_SEPARATOR = ":"
DATA_LINE_PREFIX_SKIP = "$"
DATA_LINE_SUFFIX = "seconds"


CHART_X_LABEL = "Seconds"
CHART_Y_LABEL = "Operation"
CHART_TITLE = "_________ comparision by programming language (lower is better)"


def parse_data(inp_data: list):
    technologies = {}
    current_tech = None

    for _, line in enumerate(inp_data):
        if not line or line.startswith(DATA_LINE_PREFIX_SKIP):
            continue

        if line.startswith(PRE_RECROD_STR):
            current_tech = line.split(DATA_LINE_SEPARATOR, 1)[1].strip()
            technologies[current_tech] = {}
        else:
            if DATA_LINE_SEPARATOR in line and DATA_LINE_SUFFIX in line:
                key, val = line.split(DATA_LINE_SEPARATOR, 1)
                key = key.strip().strip('"')
                val = val.replace(DATA_LINE_SUFFIX, "").strip().strip('"')
                try:
                    val = float(val)
                except ValueError:
                    continue
                technologies[current_tech][key] = val

    return technologies


def plot_comparison(technologies):
    all_keys = sorted({k for tech in technologies.values() for k in tech.keys()})

    tech_names = list(technologies.keys())
    num_techs = len(tech_names)
    y_pos = range(len(all_keys))
    bar_height = 0.8 / num_techs

    fig, ax = plt.subplots(figsize=(10, 6))

    for i, tech in enumerate(tech_names):
        values = [technologies[tech].get(k, 0) for k in all_keys]
        ax.barh(
            [y + i * bar_height for y in y_pos],
            values,
            height=bar_height,
            label=tech
        )

    ax.set_yticks([y + bar_height * (num_techs - 1) / 2 for y in y_pos])
    ax.set_yticklabels(all_keys)
    ax.set_xlabel(CHART_X_LABEL)
    ax.set_ylabel(CHART_Y_LABEL)
    ax.set_title(CHART_TITLE)
    ax.legend()
    plt.tight_layout()
    plt.show()

data = sys.stdin.readlines()
techs = parse_data(data)
plot_comparison(techs)
